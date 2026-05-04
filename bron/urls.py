from django.urls import path, include
from .views import RegisterView, BookListView, BookDetailView, BuyBookView
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)



urlpatterns = [
    path('auth/register/', RegisterView.as_view(), name='auth_register'),
    path('auth/login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('auth/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('books/', BookListView.as_view(), name='books-list'),
    path('books/<int:pk>/', BookDetailView.as_view(), name='books-detail'),
    path('buy/', BuyBookView.as_view(), name='buy-book'),
]
