# 📚 E-Library API Tizimi

Zamonaviy, xavfsiz va yuqori samarali elektron kutubxona (E-Library) tizimi. Ushbu loyiha **Django**, **Django Rest Framework (DRF)**, **Redis** va **PostgreSQL** texnologiyalari asosida ishlab chiqilgan.

---

## 🚀 Umumiy ma'lumot

Bu loyiha kitoblar, foydalanuvchilar va xarid jarayonlarini boshqarish uchun kuchli API taqdim etadi. Tizim JWT autentifikatsiya, avtomatik loglash va aqlli kesh (cache) orqali maksimal samaradorlikni ta'minlaydi.

### 🔑 Asosiy imkoniyatlar

- **Custom User Model**: Foydalanuvchilar uchun kengaytirilgan profil va balans tizimi
- **JWT Autentifikatsiya**: `djangorestframework-simplejwt` orqali xavfsiz tizim
- **Kitoblar boshqaruvi**: Kategoriya va muallif bo'yicha filter, qidiruv va tartiblash
- **Aqlli keshlash**: Kitob tafsilotlari Redis'da saqlanadi
- **Xavfsiz tranzaksiyalar**: Balans va zaxira (stock) tekshiruvi bilan atomic xarid
- **Avtomatik loglash**: Har bir API so'rov va xatolik yozib boriladi
- **Admin panel**: `django-jazzmin` bilan zamonaviy interfeys
- **API hujjatlar**: Swagger va Redoc orqali interaktiv dokumentatsiya

---

## 🛠 Texnologiyalar

- **Framework**: Django 5.x & Django Rest Framework
- **Ma'lumotlar bazasi**: PostgreSQL 15
- **Kesh/Broker**: Redis 7
- **Autentifikatsiya**: JWT (SimpleJWT)
- **Dokumentatsiya**: drf-spectacular (Swagger / Redoc)
- **Konteynerlash**: Docker & Docker Compose
- **Admin dizayn**: Jazzmin
- **Web Server**: Gunicorn + Nginx

---

## 🎯 Tanlang: Qanday Usul Bilan Boshlash Kerak?

### ✅ Option 1: Docker'da (Tavsiya - Eng Oson)
- **Vaqt**: 3-5 daqiqa
- **Talab**: Docker Desktop
- **Turdisi**: Hamma ishlar avtomatik

### ✅ Option 2: Virtual Environment (Lokal Python)
- **Vaqt**: 5-10 daqiqa  
- **Talab**: Python 3.9+
- **Turdisi**: Manual o'rnatish, flexibil

---

## 🐳 Option 1: Docker'da Ishga Tushirish (Eng Oson)

### 1️⃣ Talablar

Quyidagilar o'rnatilgan bo'lishi kerak:

| Dastur | Yuklab Olish |
|--------|------------|
| **Docker Desktop** | [docker.com](https://www.docker.com/products/docker-desktop) |
| **Git** | [git-scm.com](https://git-scm.com/download) |

### 2️⃣ O'rnatish Qadamlari

```bash
# 1️⃣ Terminal/PowerShell ochish va loyihani klonlash
git clone https://github.com/MukhammadjonArabov/E-Library.git
cd E-Library

# 2️⃣ Konteynerlarni build qilish va ishga tushirish
docker-compose up --build

# 🎉 TAYYOR! Saytga kirishingiz mumkin:
# http://localhost
```

**Bu shu kadar! Docker barcha narsani avtomatik o'rnatadi.**

### 3️⃣ Superuser (Admin) Yaratish

Boshqa terminal oynasida:

```bash
docker-compose exec web python manage.py createsuperuser
```

### 4️⃣ Brauzerda Ochish

| Nima | URL |
|------|-----|
| **API** | http://localhost |
| **Admin** | http://localhost/admin/ |
| **Swagger** | http://localhost/schema/swagger/ |
| **ReDoc** | http://localhost/schema/redoc/ |

### 5️⃣ Docker Foydali Komandalar

```bash
# Konteynerlar statusini ko'rish
docker-compose ps

# Loglarni ko'rish (real-time)
docker-compose logs -f web          # Django
docker-compose logs -f nginx        # Web Server
docker-compose logs -f db           # Database

# Bash shell oqish
docker-compose exec web bash

# Konteynerlarni to'xtatish
docker-compose down

# Barcha ma'lumotlarni o'chirib qayta boshlash
docker-compose down -v
docker-compose up --build

# Database backup yaratish
docker-compose exec db pg_dump -U elibraryuser elibrary > backup.sql
```

---

## 💻 Option 2: Lokal Kompyuterga O'rnatish (Virtual Environment)

Agar Docker'ni ishlatmagan bo'lsangiz:

### 1️⃣ Talablar

| Dastur | Yuklab Olish |
|--------|------------|
| **Python 3.9+** | [python.org](https://www.python.org/downloads/) |
| **PostgreSQL** (Optional) | [postgresql.org](https://www.postgresql.org/download/) |
| **Redis** (Optional) | [redis.io](https://redis.io/download) |
| **Git** | [git-scm.com](https://git-scm.com/download) |

### 2️⃣ O'rnatish Qadamlari

```bash
# 1️⃣ Loyihani klonlash
git clone https://github.com/MukhammadjonArabov/E-Library.git
cd E-Library

# 2️⃣ Virtual environment yaratish
python -m venv venv

# 3️⃣ Virtual environment'ni aktivlashni

# 🪟 WINDOWS:
venv\Scripts\activate

# 🍎 macOS / 🐧 Linux:
source venv/bin/activate

# 4️⃣ Dependentsiyalarni o'rnatish
pip install -r requirements.txt

# 5️⃣ Database migratsiya qilish
python manage.py migrate

# 6️⃣ Superuser yaratish
python manage.py createsuperuser

# 7️⃣ Django dev server'ni ishga tushirish
python manage.py runserver
```

### 3️⃣ Brauzerda Ochish

Shunchaki quyidagi URL'larga o'ting:

| Nima | URL |
|------|-----|
| **API** | http://127.0.0.1:8000 |
| **Admin** | http://127.0.0.1:8000/admin/ |
| **Swagger** | http://127.0.0.1:8000/schema/swagger/ |
| **ReDoc** | http://127.0.0.1:8000/schema/redoc/ |

### 4️⃣ Foydali Django Komandalar

```bash
# Virtual environment'ni aktivlash (agar deactivate qilingan bo'lsa)
# WINDOWS:
venv\Scripts\activate
# macOS / Linux:
source venv/bin/activate

# Django migrations qilish (model o'zgargan payt)
python manage.py makemigrations
python manage.py migrate

# Django admin shell
python manage.py shell

# Static fayllarni yig'ish
python manage.py collectstatic

# Cache tablesi yaratish
python manage.py createcachetable

# Tizim tekshirish
python manage.py check

# Barcha URL patterns
python manage.py show_urls
```

### 5️⃣ Development Environment Sozlamasi

`.env` fayl lokal development uchun allaqachon sozlangan:

```env
DEBUG=True
SECRET_KEY=secrit-key
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
REDIS_URL=redis://localhost:6379/1
```

---

## 🔐 SSL Sertifikati: Batafsil IzohI

### SSL Nima?

**SSL (Secure Sockets Layer)** - bu internet orqali ma'lumot uzatishdagi xavfsizlikni ta'minlaydigan texnologiya.

### 🎯 Nima Uchun Kerak?

#### 1. **🔒 Encryption (Shifrlash)**
```
Shifrsiz (HTTP):
  Username: admin
  Password: 123456
  → Hamma ko'rishi mumkin! ❌

Shifrlangan (HTTPS):
  Username: 7K9#mP2@xZ
  Password: 9QwL$eR4tY
  → Faqat siz va server ko'radi ✅
```

#### 2. **✅ Autentifikatsiya (Haqiqiylik Tekshirish)**
- Sayt haqiqiy ekanligini tasdiqlab beradi
- Phishing (aldeladigan saytlar) oldini oladi
- Brauzerda "🔒 Secure" belgisi paydo bo'ladi

#### 3. **📊 Trust va Ishonch**
- Foydalanuvchilar saytingizga ko'proq ishonadi
- Google HTTPS saytlarni birinchi joyda chiqaradi (SEO)
- Payment gateway'lar HTTPS talab qiladi

#### 4. **🛡️ Data Integrity (Ma'lumot Butunligi)**
- Ma'lumot uzatish paytida o'zgarmasligi kafolatlangan
- Hacker darhol aniqlashni haqlashadi

### 📊 HTTP vs HTTPS

```
HTTP:      http://example.com     ❌ Xavfsiz emas
HTTPS:     https://example.com    ✅ Xavfsiz (SSL bilan)

Brauzerda:
HTTP:      ⚠️ Not Secure
HTTPS:     🔒 Secure
```

### 🎁 SSL Turlari

| Tur | Qiymati | Foydalanish Joyi | Talabi |
|-----|---------|-----------------|--------|
| **Self-Signed** | Bepul | Testing, Development | Hech kim |
| **Let's Encrypt** | Bepul | Production (Tavsiya) | Domain |
| **Paid SSL** | $50-500/yil | Corporate | Domain |

### 🚀 DigitalOcean'da SSL Sozlash (Let's Encrypt)

```bash
# 1️⃣ Let's Encrypt sertifikati olish
sudo certbot certonly --webroot \
  --webroot-path /var/www/certbot \
  -d yourdomain.com \
  -d www.yourdomain.com

# 2️⃣ Sertifikatlarni kopya qilish
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem /opt/elibrary/ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem /opt/elibrary/ssl/key.pem

# 3️⃣ Nginx restart qilish
docker-compose restart nginx

# 4️⃣ Brauzerda tekshirish
https://yourdomain.com
```

### 📅 Sertifikat Yangilash (Avtomatik)

```bash
# Crontab'ga qo'shish (har 60 kunda tekshirish)
sudo crontab -e

# Qo'shish:
0 2 * * * certbot renew --quiet && \
  cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem /opt/elibrary/ssl/cert.pem && \
  cp /etc/letsencrypt/live/yourdomain.com/privkey.pem /opt/elibrary/ssl/key.pem && \
  docker restart elibrary_nginx
```

---

## 🌐 DigitalOcean'ga Deploy Qilish

Loyihangizni production serverga deploy qilishning to'liq qo'llanmasi:

📖 **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Batafsil deploy qo'llanmasi

### ⚡ Tez Deploy (Quick Deploy)

```bash
# 1️⃣ SSH orqali serverga ulanish
ssh root@YOUR_DROPLET_IP

# 2️⃣ Server sozlash skriptini ishga tushirish
curl https://raw.githubusercontent.com/YOUR_USERNAME/E-Library/main/setup-server.sh | sudo bash

# 3️⃣ Loyihani klonlash
mkdir -p /opt/elibrary
cd /opt/elibrary
git clone https://github.com/YOUR_USERNAME/E-Library.git .

# 4️⃣ .env faylini sozlash
cp .env.example .env
nano .env
# ⚠️ yourdomain.com va parollarni o'zgartiring

# 5️⃣ SSL sertifikati yaratish
bash init-ssl.sh

# 6️⃣ Loyihani deploy qilish
bash deploy.sh
```

### 📋 Deploy Scriptlari

| Script | Maqsali |
|--------|--------|
| **setup-server.sh** | Server o'ritish (Docker, Firewall, etc.) |
| **deploy.sh** | Loyihani deploy qilish va migratsiya |
| **health-check.sh** | Tizim status tekshirish |
| **init-ssl.sh** | SSL sertifikati yaratish |

---

## 📊 Loyiha Tuzilishi

```
E-Library/
├── config/                      # Django sozlamasi
│   ├── settings.py             # Production configs
│   ├── urls.py
│   ├── wsgi.py
│   └── asgi.py
├── bron/                        # Asosiy app (Books, Users, Orders)
│   ├── models.py
│   ├── views.py
│   ├── serializers.py
│   ├── urls.py
│   └── migrations/
├── staticfiles/                 # CSS, JS (generate qilinadi)
├── media/                       # User uploads
├── logs/                        # Application logs
├── ssl/                         # SSL sertifikatlari
├── docker-compose.yml          # Docker configuration
├── Dockerfile                  # Web container
├── nginx.conf                  # Nginx config
├── entrypoint.sh              # Startup script
├── setup-server.sh            # Server setup
├── deploy.sh                  # Deploy script
├── health-check.sh            # Health check
├── init-ssl.sh                # SSL setup
├── requirements.txt           # Python packages
├── .env.example               # Environment template
├── DEPLOYMENT.md              # Production guide
└── README.md                  # Bu fayl
```

---

## 🔐 Xavfsizlik

### ✅ Qo'llanilgan Xavfsizlik Choralari

- ✅ **JWT Token** - Autentifikatsiya
- ✅ **CORS** - Cross-origin security
- ✅ **HTTPS/SSL** - Data encryption
- ✅ **Environment Variables** - Secret management
- ✅ **CSRF Protection** - Django built-in
- ✅ **SQL Injection Defense** - Django ORM
- ✅ **Request Logging** - Audit trail
- ✅ **Rate Limiting** - API protection
- ✅ **Security Headers** - Nginx konfiguratsiya

---

## 📞 Muammolarni Hal Qilish

### 🐳 Docker Muammolari

```bash
# Konteynerlarni restart qilish
docker-compose restart

# Barcha ma'lumotlarni o'chirib qayta boshlash
docker-compose down -v
docker-compose up --build

# Docker image'larni tozalash
docker system prune -a

# Bitta konteyner log'larini ko'rish
docker-compose logs -f web
```

### 💾 Database Muammolari

```bash
# Database statusini tekshirish
docker-compose exec db pg_isready

# Backup yaratish
docker-compose exec db pg_dump -U elibraryuser elibrary > backup.sql

# Backup'dan restore qilish
docker-compose exec db psql -U elibraryuser elibrary < backup.sql

# Database'ga kirish
docker-compose exec db psql -U elibraryuser -d elibrary
```

### 🌐 Nginx/Web Muammolari

```bash
# Nginx configuration tekshirish
docker-compose exec nginx nginx -t

# Nginx restart qilish
docker-compose restart nginx

# Port 80 va 443 tushunadigan jarayonni topish
sudo lsof -i :80
sudo lsof -i :443

# Jarayonni o'ldirish
kill -9 PID
```

### 🐍 Python/Django Muammolari

```bash
# Django check qilish
docker-compose exec web python manage.py check

# Database migratsiyalarini tekshirish
docker-compose exec web python manage.py migrate --check

# Django shell orqali test qilish
docker-compose exec web python manage.py shell

# Logs'dan error'larni ko'rish
grep ERROR logs/all.log
```

---

## 📚 Foydali Linklar

| Nomi | Sayt |
|------|------|
| **Django** | [docs.djangoproject.com](https://docs.djangoproject.com/) |
| **DRF** | [django-rest-framework.org](https://www.django-rest-framework.org/) |
| **Docker** | [docs.docker.com](https://docs.docker.com/) |
| **DigitalOcean** | [docs.digitalocean.com](https://www.digitalocean.com/docs/) |
| **Let's Encrypt** | [letsencrypt.org](https://letsencrypt.org/) |
| **PostgreSQL** | [postgresql.org](https://www.postgresql.org/docs/) |
| **Redis** | [redis.io](https://redis.io/docs/) |

---

## 🆘 Support

Muammolar bo'lsa:

1. **Log'larni ko'ring** → `docker-compose logs -f`
2. **Health check** → `bash health-check.sh`
3. **DEPLOYMENT.md'ni o'qing** → Batafsil qo'llanma
4. **GitHub Issues** → [Issues](https://github.com/MukhammadjonArabov/E-Library/issues)

---

## 📝 Litsenziya

Bu loyiha **MIT** litsenziyasi asosida tarqatiladi.

---

## ✨ Contributor'lar

- **Mukhammadjon Arabov** - E-Library yaratuvchisi

---

**Happy coding! 🚀**
