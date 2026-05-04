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
```

---

## 🌐 DigitalOcean'ga Deploy qilish

Loyihangizni production serverga deploy qilishning to'liq qo'llanmasi uchun qarang:

📖 **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Batafsil deploy qo'llanmasi

### Tez deploy (Quick Deploy)

```bash
# 1. Server sozlash (SSH orqali serverda)
curl https://raw.githubusercontent.com/YOUR_USERNAME/E-Library/main/setup-server.sh | bash

# 2. Loyihani klonlash
cd /opt/elibrary
git clone https://github.com/YOUR_USERNAME/E-Library.git .

# 3. .env faylini sozlash
cp .env.example .env
nano .env

# 4. SSL sertifikat olish
certbot certonly --webroot -d yourdomain.com -d www.yourdomain.com

# 5. Deploy qilish
bash deploy.sh
```

### Deploy Scriptlari

| Script | Maqsadi |
|--------|--------|
| **setup-server.sh** | Server o'ritish (Docker, Firewall, etc.) |
| **deploy.sh** | Loyihani deploy qilish |
| **health-check.sh** | Tizim status tekshirish |

### Docker Komandalar

```bash
# Konteynerlarni ko'rish
docker-compose ps

# Log'larni ko'rish
docker-compose logs -f web
docker-compose logs -f nginx
docker-compose logs -f db

# Django shell
docker-compose exec web python manage.py shell

# Database migration
docker-compose exec web python manage.py migrate

# Superuser yaratish
docker-compose exec web python manage.py createsuperuser

# Static fayllarni yig'ish
docker-compose exec web python manage.py collectstatic --noinput

# Health check
bash health-check.sh
```

### SSL/HTTPS

Nginx avtomatik SSL'ni sozlaydigan qilingan, faqat sertifikatlarni `/ssl` papkasiga qo'shish kerak:
- `ssl/cert.pem` - Sertifikat
- `ssl/key.pem` - Private key

---

## 📊 Loyiha Tuzilishi

```
E-Library/
├── config/           # Django asosiy sozlash
│   ├── settings.py   # Production sozlamalar
│   ├── urls.py
│   ├── wsgi.py
│   └── asgi.py
├── bron/            # Asosiy app (Kitoblar, Foydalanuvchilar, Xarid)
│   ├── models.py
│   ├── views.py
│   ├── serializers.py
│   ├── urls.py
│   └── migrations/
├── docker-compose.yml  # Docker konfiguratsiya
├── Dockerfile          # Web container
├── nginx.conf          # Nginx server sozlash
├── entrypoint.sh       # Container startup script
├── deploy.sh           # Deploy script
├── health-check.sh     # Sog'lik tekshirish
├── setup-server.sh     # Server o'ritish
├── requirements.txt    # Python paketlari
└── README.md          # Bu fayl
```

---

## 🔐 Xavfsizlik

- ✅ JWT Token orqali autentifikatsiya
- ✅ CORS sozlamalar
- ✅ HTTPS/SSL encryption
- ✅ Environment variables qo'llanish
- ✅ CSRF protection
- ✅ SQL injection himoyasi (ORM)
- ✅ Request logging va error tracking

---

## 📞 Muammolarni hal qilish

### Docker masalalari

```bash
# Konteynerlarni restart
docker-compose restart

# Barcha ma'lumotlarni o'chirib qayta o'ritish
docker-compose down -v
docker-compose up -d

# Konteyner log'larini ko'rish
docker-compose logs <container_name>
```

### Database masalalari

```bash
# Database statusini tekshirish
docker-compose exec db pg_isready

# Backup yaratish
docker-compose exec db pg_dump -U elibraryuser elibrary > backup.sql

# Backup qayta ishlash
docker-compose exec db psql -U elibraryuser elibrary < backup.sql
```

---

## 📚 Foydali linklar

- [Django Documentation](https://docs.djangoproject.com/)
- [DRF Documentation](https://www.django-rest-framework.org/)
- [Docker Documentation](https://docs.docker.com/)
- [DigitalOcean Docs](https://www.digitalocean.com/docs/)

---

## 📝 Litsenziya

Bu loyiha MIT litsenziyasi asosida tarqatiladi.

---

**Savol yoki masala bo'lsa, GitHub Issues orqali murojaat qiling.**