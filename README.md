# 📚 E-Library API Tizimi

Zamonaviy, xavfsiz va yuqori samarali elektron kutubxona (E-Library) tizimi. Ushbu loyiha **Django**, **Django Rest Framework (DRF)**, **Redis** va **PostgreSQL** texnologiyalari asosida ishlab chiqilgan.

---

## 🚀 Umumiy ma’lumot

Bu loyiha kitoblar, foydalanuvchilar va xarid jarayonlarini boshqarish uchun kuchli API taqdim etadi. Tizim JWT autentifikatsiya, avtomatik loglash va aqlli kesh (cache) orqali maksimal samaradorlikni ta’minlaydi.

### 🔑 Asosiy imkoniyatlar

- **Custom User Model**: Foydalanuvchilar uchun kengaytirilgan profil va balans tizimi
- **JWT Autentifikatsiya**: `djangorestframework-simplejwt` orqali xavfsiz tizim
- **Kitoblar boshqaruvi**: Kategoriya va muallif bo‘yicha filter, qidiruv va tartiblash
- **Aqlli keshlash**: Kitob tafsilotlari Redis’da saqlanadi
- **Xavfsiz tranzaksiyalar**: Balans va zaxira (stock) tekshiruvi bilan atomic xarid
- **Avtomatik loglash**: Har bir API so‘rov va xatolik yozib boriladi
- **Admin panel**: `django-jazzmin` bilan zamonaviy interfeys
- **API hujjatlar**: Swagger va Redoc orqali interaktiv dokumentatsiya

---

## 🛠 Texnologiyalar

- **Framework**: Django 5.x & Django Rest Framework
- **Ma’lumotlar bazasi**: PostgreSQL 15
- **Kesh/Broker**: Redis 7
- **Autentifikatsiya**: JWT (SimpleJWT)
- **Dokumentatsiya**: drf-spectacular (Swagger / Redoc)
- **Konteynerlash**: Docker & Docker Compose
- **Admin dizayn**: Jazzmin

---

## 🐳 Docker orqali ishga tushirish (Tavsiya etiladi)

Loyihani ishga tushirishning eng oson usuli — Docker’dan foydalanish. Bu avtomatik ravishda Python muhit, PostgreSQL va Redis’ni sozlaydi.

### 1. Talablar

Quyidagilar o‘rnatilgan bo‘lishi kerak:
- Docker
- Docker Compose

### 2. Environment sozlash

Loyihada `.env` fayl allaqachon sozlangan. Lokal ishlash uchun uni o‘zgartirish shart emas.

### 3. Loyihani ishga tushirish

```bash
git clone https://github.com/MukhammadjonArabov/E-Library.git
cd E-Library
docker-compose up --build
docker-compose exec web python manage.py createsuperuser