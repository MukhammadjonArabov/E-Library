from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator
from decimal import Decimal

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    balance = models.DecimalField(max_digits=12, decimal_places=2, default=0.00, validators=[MinValueValidator(Decimal('0.00'))])

    def __str__(self):
        return self.username

class Author(models.Model):
    name = models.CharField(max_length=255)
    bio = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name

class Category(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        verbose_name_plural = "Categories"

    def __str__(self):
        return self.name

class Book(models.Model):
    title = models.CharField(max_length=255) # nomi
    author = models.ForeignKey(Author, on_delete=models.CASCADE, related_name='books') # muallif
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, related_name='books') # janr
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00) # narxi
    stock_count = models.PositiveIntegerField(default=1) # mavjud nusxalar soni
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class Transaction(models.Model):
    TYPE_CHOICES = [
        ('BUY', 'Sotib olish'),
        ('RENT', 'Ijara'),
    ]

    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name='transactions')
    book = models.ForeignKey(Book, on_delete=models.CASCADE, related_name='transactions')
    transaction_type = models.CharField(max_length=10, choices=TYPE_CHOICES, default='BUY') # tur
    quantity = models.PositiveIntegerField(default=1) # kitoblar soni
    created_at = models.DateTimeField(auto_now_add=True) # sana

    def __str__(self):
        return f"{self.user.username} - {self.book.title} ({self.transaction_type})"

class LogEntry(models.Model):
    LEVEL_CHOICES = [
        ('INFO', 'Info'),
        ('WARNING', 'Warning'),
        ('ERROR', 'Error'),
        ('CRITICAL', 'Critical'),
    ]
    level = models.CharField(max_length=10, choices=LEVEL_CHOICES)
    message = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "System Logs"
        ordering = ['-timestamp']

    def __str__(self):
        return f"[{self.level}] {self.message[:50]}..."
