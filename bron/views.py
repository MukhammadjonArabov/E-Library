from rest_framework import generics, status, filters
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.views import APIView
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from django.core.cache import cache
from django.db import transaction
from .models import Book, Transaction, CustomUser, LogEntry
from .serializers import RegisterSerializer, BookSerializer, UserSerializer
from drf_spectacular.utils import extend_schema, OpenApiParameter
from django_filters.rest_framework import DjangoFilterBackend
import logging

logger = logging.getLogger('bron')

# A. Autentifikatsiya
@extend_schema(tags=['Auth'])
class RegisterView(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    permission_classes = (AllowAny,)
    serializer_class = RegisterSerializer

# B. Kitoblar boshqaruvi
@extend_schema(
    tags=['Books'],
    parameters=[
        OpenApiParameter(name='category', description='Filter by category ID', required=False, type=int),
        OpenApiParameter(name='author', description='Filter by author ID', required=False, type=int),
    ]
)
class BookListView(generics.ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['category', 'author']
    search_fields = ['title', 'author__name', 'category__name']
    ordering_fields = ['price', 'created_at']
    permission_classes = [IsAuthenticated]

@extend_schema(tags=['Books'])
class BookDetailView(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request, pk):
        book = get_object_or_404(Book, pk=pk)
        serializer = BookSerializer(book)
        return Response(serializer.data)

# D. Savdo jarayoni (Logika)
@extend_schema(
    tags=['Sales'],
    request={
        'application/json': {
            'type': 'object',
            'properties': {
                'book_id': {'type': 'integer', 'description': 'ID of the book to buy'},
                'quantity': {'type': 'integer', 'description': 'Number of copies', 'default': 1}
            },
            'required': ['book_id']
        }
    },
    responses={
        200: {'type': 'object', 'properties': {'message': {'type': 'string'}}},
        400: {'type': 'object', 'properties': {'error': {'type': 'string'}}}
    }
)
class BuyBookView(APIView):
    permission_classes = [IsAuthenticated]
    
    @transaction.atomic
    def post(self, request):
        user = request.user
        
        # Ma'lumotlarni olish
        book_id = request.data.get('book_id')
        quantity_raw = request.data.get('quantity', 1)

        # Validatsiya: book_id bo'lishi shart
        if not book_id:
            return Response({"error": "book_id kiritilishi shart."}, status=status.HTTP_400_BAD_REQUEST)

        # Validatsiya: Kitob mavjudligi
        book = get_object_or_404(Book.objects.select_for_update(), pk=book_id)

        # Validatsiya: Miqdor raqam bo'lishi kerak
        try:
            quantity = int(quantity_raw)
        except (ValueError, TypeError):
            return Response({"error": "Kitoblar soni raqam bo'lishi kerak."}, status=status.HTTP_400_BAD_REQUEST)
        
        # Validatsiya: Miqdor musbat bo'lishi kerak
        if quantity <= 0:
            return Response({"error": "Kitoblar soni kamida 1 ta bo'lishi kerak."}, status=status.HTTP_400_BAD_REQUEST)

        total_price = book.price * quantity

        # Tekshiruv: Foydalanuvchi balansi yetarlimi?
        if user.balance < total_price:
            msg = f"User {user.username} (ID: {user.id}) has insufficient balance ({user.balance}) for {quantity} copies of book {book.title} (Total: {total_price})"
            logger.error(msg)
            LogEntry.objects.create(level='ERROR', message=msg)
            return Response({
                "error": "Balans yetarli emas.",
                "details": {
                    "total_price": total_price,
                    "your_balance": user.balance,
                    "shortage": total_price - user.balance
                }
            }, status=status.HTTP_400_BAD_REQUEST)
            
        # Tekshiruv: Mavjud nusxalar bormi?
        if book.stock_count < quantity:
            msg = f"Book {book.title} (ID: {book.id}) stock ({book.stock_count}) is less than requested quantity ({quantity})."
            logger.error(msg)
            LogEntry.objects.create(level='ERROR', message=msg)
            return Response({
                "error": "Kitob bazada yetarli emas.",
                "details": {
                    "requested": quantity,
                    "available": book.stock_count
                }
            }, status=status.HTTP_400_BAD_REQUEST)
            
        # Natija: Balansdan pul yechiladi
        user.balance -= total_price
        user.save()
        
        # Kitob soni kamayadi
        book.stock_count -= quantity
        book.save()
        
        # Tranzaksiya yoziladi
        Transaction.objects.create(
            user=user,
            book=book,
            transaction_type='BUY',
            quantity=quantity
        )
        
        logger.info(f"User {user.username} successfully bought {quantity} copies of book {book.title}.")
        return Response({
            "message": "Kitob(lar) muvaffaqiyatli sotib olindi.",
            "data": {
                "book_title": book.title,
                "quantity": quantity,
                "total_price": total_price,
                "remaining_balance": user.balance,
                "remaining_stock": book.stock_count
            }
        }, status=status.HTTP_200_OK)
