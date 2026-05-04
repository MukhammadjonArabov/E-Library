from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Author, Category, Book, Transaction, CustomUser, LogEntry

@admin.register(LogEntry)
class LogEntryAdmin(admin.ModelAdmin):
    list_display = ('level', 'message', 'timestamp')
    list_filter = ('level', 'timestamp')
    search_fields = ('message',)
    readonly_fields = ('level', 'message', 'timestamp')

    def has_add_permission(self, request):
        return False

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'balance', 'is_staff')
    list_editable = ('balance',)  # Ro'yxatning o'zida tahrirlash imkoniyati
    fieldsets = UserAdmin.fieldsets + (
        (None, {'fields': ('balance',)}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        (None, {'fields': ('balance',)}),
    )

@admin.register(Author)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)

@admin.register(Book)
class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'category', 'stock_count', 'price')
    list_filter = ('author', 'category')
    search_fields = ('title', 'description')

@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ('user', 'book', 'transaction_type', 'quantity', 'created_at')
    list_filter = ('transaction_type', 'created_at')
    search_fields = ('user__username', 'book__title')
