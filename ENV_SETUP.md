# 🔐 Environment Variables (.env) Qo'llanmasi

## 📋 Asosiy Sozlamalar

### 🔧 Django Sozlamasi

#### `SECRET_KEY`
- **Nima**: Django uchun xavfsiz kalit
- **Muhim**: ❌ HECH QACHON Git'ga commit qilmang!
- **Generatsiya qilish**:
  ```bash
  python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
  ```
- **Misol**:
  ```
  SECRET_KEY=django-insecure-7k9#mP2@xZ$qwL$eR4tY9QwL$eR4tY9QwL$eR4tY9QwL
  ```

#### `DEBUG`
- **Development**: `DEBUG=True` ✅
- **Production**: `DEBUG=False` ✅ (IMPORTANT!)
- **Misol**:
  ```
  DEBUG=False
  ```

#### `ALLOWED_HOSTS`
- **Nima**: Qaysi domain'lardan kirish mumkin
- **Development**: `localhost,127.0.0.1`
- **Production**: `yourdomain.com,www.yourdomain.com`
- **Misol**:
  ```
  ALLOWED_HOSTS=example.com,www.example.com,api.example.com
  ```

---

### 🗄️ Database Sozlamasi (PostgreSQL)

#### `POSTGRES_DB`
- **Nima**: Database nomi
- **Default**: `elibrary`
- **O'zgartirgani**: Kerak bo'lsa
- **Misol**:
  ```
  POSTGRES_DB=elibrary_prod
  ```

#### `POSTGRES_USER`
- **Nima**: Database user nomi
- **Default**: `elibraryuser`
- **Xavfsizlik**: Xavfsiz nom ishlating
- **Misol**:
  ```
  POSTGRES_USER=elibrary_user_prod
  ```

#### `POSTGRES_PASSWORD`
- **Nima**: Database parol
- **Muhim**: 🔒 Xavfsiz parol (min 20 harf)
- **Misol parol**:
  ```
  k7mP2@xZ$qwL$eR4tY9QwL$eR4tY9QwL$eR
  ```
- **Qo'shimcha**:
  - Raqamlar qamashtirish: 123456
  - Katta harf: A-Z
  - Kichik harf: a-z
  - Special char: @#$%^&

#### `POSTGRES_HOST`
- **Docker'da**: `db` (container nomi)
- **Lokal**: `localhost` yoki `127.0.0.1`
- **Production**: Database server IP yoki hostname
- **Misol**:
  ```
  POSTGRES_HOST=db
  ```

#### `POSTGRES_PORT`
- **Standart**: `5432`
- **O'zgartirgani**: Kam hollarda
- **Misol**:
  ```
  POSTGRES_PORT=5432
  ```

---

### 💾 Redis (Cache) Sozlamasi

#### `REDIS_URL`
- **Nima**: Redis connection string
- **Docker'da**: `redis://redis:6379/1`
- **Lokal**: `redis://localhost:6379/1`
- **Production**: `redis://redis-host:6379/1`
- **Misol**:
  ```
  REDIS_URL=redis://redis:6379/1
  ```

**Format**: `redis://[host]:[port]/[db_number]`
- `host`: Redis serveri
- `port`: Port (standart 6379)
- `db_number`: Database nomeri (0-15)

---

### 🌐 CORS va Frontend Sozlamasi

#### `CORS_ALLOWED_ORIGINS`
- **Nima**: Qaysi frontend saytlardan API call qilish mumkin
- **Development**: `http://localhost:3000`
- **Production**: `https://yourdomain.com`
- **Comma separated**: Bir nechta sayt bo'lsa, vergul bilan ajratiladi
- **Misol**:
  ```
  CORS_ALLOWED_ORIGINS=https://example.com,https://www.example.com,https://app.example.com
  ```

---

### 📧 Email Konfiguratsiyasi (Optional)

#### `EMAIL_BACKEND`
- **Standart Django**: `django.core.mail.backends.smtp.EmailBackend`
- **Console (Debug)**: `django.core.mail.backends.console.EmailBackend`
- **Misol**:
  ```
  EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
  ```

#### `EMAIL_HOST`
- **Gmail**: `smtp.gmail.com`
- **SendGrid**: `smtp.sendgrid.net`
- **Misol**:
  ```
  EMAIL_HOST=smtp.gmail.com
  ```

#### `EMAIL_PORT`
- **TLS bilan**: `587`
- **SSL bilan**: `465`
- **Misol**:
  ```
  EMAIL_PORT=587
  ```

#### `EMAIL_USE_TLS`
- **Gmail**: `True`
- **Misol**:
  ```
  EMAIL_USE_TLS=True
  ```

#### `EMAIL_HOST_USER`
- **Gmail**: `your-email@gmail.com`
- **Misol**:
  ```
  EMAIL_HOST_USER=your-email@gmail.com
  ```

#### `EMAIL_HOST_PASSWORD`
- **Gmail**: App-specific password (2FA ishlayotgan bo'lsa)
- **Misol**:
  ```
  EMAIL_HOST_PASSWORD=ywyz zzzz zzzz zzzz
  ```

---

## 🔄 Environment Setup by Scenario

### 📱 Scenario 1: Lokal Development (Docker)

```env
DEBUG=True
SECRET_KEY=your-dev-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1

POSTGRES_DB=elibrary
POSTGRES_USER=elibraryuser
POSTGRES_PASSWORD=elibrarypass
POSTGRES_HOST=db
POSTGRES_PORT=5432

REDIS_URL=redis://redis:6379/1

CORS_ALLOWED_ORIGINS=http://localhost:3000,http://localhost:5173
```

### 💻 Scenario 2: Lokal Development (Python venv)

```env
DEBUG=True
SECRET_KEY=your-dev-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1

POSTGRES_DB=elibrary_local
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

REDIS_URL=redis://localhost:6379/1

CORS_ALLOWED_ORIGINS=http://localhost:3000,http://localhost:5173

EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
```

### 🌐 Scenario 3: Production (DigitalOcean)

```env
DEBUG=False
SECRET_KEY=generate-new-strong-secret-key
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

POSTGRES_DB=elibrary_prod
POSTGRES_USER=elib_prod_user
POSTGRES_PASSWORD=VERY_STRONG_PASSWORD_MIN_20_CHARS
POSTGRES_HOST=db
POSTGRES_PORT=5432

REDIS_URL=redis://redis:6379/1

CORS_ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com

EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=noreply@yourdomain.com
EMAIL_HOST_PASSWORD=your-app-password
```

---

## 🔒 Security Best Practices

### ✅ DO (Qilish Kerak)

```
✅ SECRET_KEY'ni har safar yangi generatsiya qilish
✅ Parol min 20 ta harf
✅ Special characters ishlatish (@#$%^&)
✅ .env faylni .gitignore'ga qo'shish
✅ Production uchun yangi SECRET_KEY yaratish
✅ DEBUG=False production'da
✅ Environment variables'ni server'da sozlash
```

### ❌ DON'T (Qilmasligi Kerak)

```
❌ .env faylni Git'ga commit qilmash
❌ Sodoq parollar ishlatmash (123456)
❌ Production SECRET_KEY'ni development'da foydalanmash
❌ CORS_ALLOWED_ORIGINS='*' production'da
❌ DEBUG=True production'da
❌ Parollarni kod'ga direct yozish
```

---

## 🔧 .env Faylini Tayyorlash

### Step 1: Shablonni Nusxalash
```bash
cp .env.example .env
```

### Step 2: .env'ni Edit Qilish
```bash
# Windows:
notepad .env

# macOS/Linux:
nano .env
```

### Step 3: Values'ni Qo'shish
Savolga javob bering va qo'shish

### Step 4: Saqlash
- Windows Notepad: Ctrl+S
- nano: Ctrl+X → Y → Enter

### Step 5: Tekshirish
```bash
# Docker'da
docker-compose config

# Python'da
python manage.py check
```

---

## 🆘 Xatoliklar va Yechimlari

| Xato | Sabab | Yechim |
|------|------|--------|
| `SECRET_KEY missing` | .env'da SECRET_KEY yo'q | generate qilish: python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())" |
| `Database connection error` | POSTGRES_* noto'g'ri | .env'da host/user/pass tekshirish |
| `CORS error` | CORS_ALLOWED_ORIGINS | Frontend domain'ni qo'shish |
| `DEBUG=True` | Production xavfsizlik | DEBUG=False qilish |
| `Port in use` | Boshqa app port bilan ishla | POSTGRES_PORT o'zgartirizh |

---

## 📝 .env Checklist

```
Before Development:
☐ .env fayl klonlangan papka'da
☐ SECRET_KEY ko'p bo'lgan
☐ DEBUG=True
☐ POSTGRES_HOST=localhost yoki db

Before Production:
☐ DEBUG=False
☐ SECRET_KEY yangi generate qilgan
☐ ALLOWED_HOSTS to'g'ri domain
☐ POSTGRES_PASSWORD xavfsiz
☐ CORS_ALLOWED_ORIGINS to'g'ri
☐ EMAIL settings agar kerak bo'lsa
☐ REDIS_URL to'g'ri
```

---

## 🚀 Example: Complete .env Setup

```env
# ====== Django =======
DEBUG=False
SECRET_KEY=django-insecure-7k9#mP2@xZ$qwL$eR4tY9QwL$eR4tY9QwL$eR4tY9QwL
ALLOWED_HOSTS=myelib.com,www.myelib.com

# ====== Database =======
POSTGRES_DB=elibrary_prod
POSTGRES_USER=elib_user
POSTGRES_PASSWORD=SuperSecure@Password123#
POSTGRES_HOST=db
POSTGRES_PORT=5432

# ====== Redis =======
REDIS_URL=redis://redis:6379/1

# ====== CORS =======
CORS_ALLOWED_ORIGINS=https://myelib.com,https://www.myelib.com

# ====== Email (Optional) =======
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=noreply@myelib.com
EMAIL_HOST_PASSWORD=ywyz zzzz zzzz zzzz
```

---

**Savollar bo'lsa, README.md yoki DEPLOYMENT.md'ni o'qing!**
