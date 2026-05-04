from rest_framework import serializers
from .models import Author, Category, Book, Transaction, CustomUser

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id', 'username', 'email', 'balance']

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    email = serializers.EmailField(required=True)

    class Meta:
        model = CustomUser
        fields = ('username', 'password', 'email')

    def validate_email(self, value):
        if CustomUser.objects.filter(email=value).exists():
            raise serializers.ValidationError("Ushbu email manzili allaqachon ro'yxatdan o'tgan.")
        return value

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        return user

class AuthorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Author
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class BookSerializer(serializers.ModelSerializer):
    author_name = serializers.ReadOnlyField(source='author.name')
    category_name = serializers.ReadOnlyField(source='category.name')

    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'author_name', 'category', 'category_name', 'price', 'stock_count', 'description', 'created_at']

class TransactionSerializer(serializers.ModelSerializer):
    user_name = serializers.ReadOnlyField(source='user.username')
    book_title = serializers.ReadOnlyField(source='book.title')

    class Meta:
        model = Transaction
        fields = ['id', 'user', 'user_name', 'book', 'book_title', 'transaction_type', 'quantity', 'created_at']
