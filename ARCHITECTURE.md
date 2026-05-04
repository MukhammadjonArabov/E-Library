# 📚 E-Library Setup - Tashrihat

## 🎯 Loyihani Tanlang

```
┌─────────────────────────────────┐
│   E-Library Loyihasini Boshlash  │
└──────────────┬──────────────────┘
               │
        ┌──────┴──────┐
        │             │
    ┌───▼───┐    ┌───▼────┐
    │ DOCKER│    │PYTHON  │
    │ (Easy)│    │(Manual)│
    └───┬───┘    └───┬────┘
        │            │
        │            │
        │            │
```

---

## 🐳 Docker Path (3 Daqiqa)

```
1. Install Docker Desktop
        ↓
2. git clone
        ↓
3. docker-compose up --build
        ↓
4. Open http://localhost
        ↓
🎉 DONE!
```

---

## 🐍 Python Path (10 Daqiqa)

```
1. Install Python 3.9+
        ↓
2. git clone
        ↓
3. python -m venv venv
        ↓
4. venv\Scripts\activate (Windows)
   source venv/bin/activate (Mac/Linux)
        ↓
5. pip install -r requirements.txt
        ↓
6. python manage.py migrate
        ↓
7. python manage.py runserver
        ↓
8. Open http://127.0.0.1:8000
        ↓
🎉 DONE!
```

---

## 🔐 SSL Sertifikati Qanday Ishlaydi?

### ✅ HTTPS (SSL Bilan)

```
Foydalanuvchi          Server
    │                   │
    ├─ HTTPS So'rov ──→ │  🔒 Shifrlangan
    │   (Username)      │     ↓
    │   (Password)      │  Shifrni o'qish
    │                   │     ↓
    │  ← JWT Token ─────┤  Shifrlangan
    │   (Xavfsiz)       │
    │                   │
```

### ❌ HTTP (Shifrsiz - Xavfsiz Emas)

```
Foydalanuvchi          Server
    │                   │
    ├─ HTTP So'rov ──→  │  ⚠️ Hammasi ko'rinib turadi
    │   (Username)      │     ↓
    │   (Password)      │  Hacker ko'rishi mumkin
    │                   │     ↓
    │  ← Javob ─────────┤  ⚠️ Shifrsiz
    │   (Tekishligi)    │
    │                   │
```

---

## 🌐 DigitalOcean Deploy Flow

```
┌─────────────────────┐
│  DigitalOcean       │
│  Create Droplet     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Install Docker     │
│  Install Git        │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Clone E-Library    │
│  Update .env file   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Get SSL Cert       │
│  (Let's Encrypt)    │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  docker-compose     │
│  up --build         │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  ✅ LIVE!          │
│  https://yourdomain│
└─────────────────────┘
```

---

## 📊 Architecture Tushuntirish

### Docker Tuzilishi

```
┌─────────────────────────────────────────────┐
│          Internet (Brauzer)                  │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │   NGINX (Proxy)      │
        │  Port 80, 443        │
        │  ✅ SSL/HTTPS        │
        │  ✅ Static files     │
        └──────┬───────────────┘
               │
        ┌──────┴──────────────┐
        │                     │
        ▼                     ▼
   ┌─────────────┐      ┌──────────┐
   │  DJANGO WEB │      │  JOBS    │
   │  Gunicorn   │      │ (Worker) │
   │  Port 8000  │      │          │
   └──────┬──────┘      └──────────┘
          │
    ┌─────┴─────────┬──────────────┐
    │               │              │
    ▼               ▼              ▼
┌────────────┐ ┌─────────┐ ┌──────────────┐
│ PostgreSQL │ │  Redis  │ │   Logs       │
│  Database  │ │  Cache  │ │  (File sys)  │
└────────────┘ └─────────┘ └──────────────┘
```

### Virtual Environment Tuzilishi

```
┌──────────────────────────────────┐
│         Internet (Brauzer)        │
└──────────────────┬────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │    Django Dev        │
        │    Port 8000         │
        │  (runserver)         │
        └──────┬───────────────┘
               │
    ┌──────────┴────────────┐
    │                       │
    ▼                       ▼
┌─────────────┐      ┌──────────────┐
│  SQLite DB  │      │   Virtual    │
│  (Local)    │      │  Environment │
└─────────────┘      └──────────────┘
```

---

## 🔄 Database Tuziligi

### Models Tuzilishi

```
┌─────────────────────┐
│   CustomUser        │
├─────────────────────┤
│ • email             │
│ • balance           │
│ • created_at        │
└────────┬────────────┘
         │
         │ 1:N
         │
    ┌────▼──────────┐
    │   Orders      │
    ├───────────────┤
    │ • user        │◄─────┐
    │ • book        │◄─┐   │
    │ • quantity    │  │   │
    │ • timestamp   │  │   │
    └───────────────┘  │   │
                       │   │
    ┌──────────────────┘   │
    │                      │
    ▼                      ▼
┌──────────────┐  ┌─────────────────┐
│   Books      │  │  Categories     │
├──────────────┤  ├─────────────────┤
│ • title      │  │ • name          │
│ • author     │  │ • description   │
│ • category   │  │                 │
│ • price      │  │                 │
│ • stock      │  │                 │
└──────────────┘  └─────────────────┘
```

---

## 🔐 Authentication Flow

### JWT Token Qanday Ishlaydi?

```
┌─ Foydalanuvchi ─┐
│                 │
│  1. Login       │
│  username:      │
│  password:      │
└────────┬────────┘
         │
         │ HTTP POST /api/token/
         │
         ▼
    ┌──────────────────┐
    │  Django Server   │
    │                  │
    │  Check user &    │
    │  password        │
    └────────┬─────────┘
             │
             │ Create JWT Token
             │ ├─ header
             │ ├─ payload (user_id, exp)
             │ └─ signature (secret_key)
             │
             ▼
    ┌──────────────────┐
    │  Return Token    │
    │  eyJhbGc...      │
    └────────┬─────────┘
             │
         HTTP 200 OK
         ├─ access_token
         ├─ refresh_token
         └─ expires_in
             │
             ▼
    ┌─ Foydalanuvchi ─┐
    │                 │
    │  Saqlab turadi  │
    │  local storage  │
    └────────┬────────┘
             │
    2. Next Requests:
             │
    Header: Authorization: Bearer eyJhbGc...
             │
             ▼
    ┌──────────────────┐
    │  Django Server   │
    │                  │
    │  Verify Token    │
    │  (signature)     │
    │                  │
    │  Valid?          │
    │  ✅ Yes → Process
    │  ❌ No  → 401 Error
    └──────────────────┘
```

---

## 📊 Request/Response Cycle

### API Call Example

```
CLIENT                  NGINX              DJANGO             DATABASE
  │                       │                  │                    │
  │ 1. GET /api/books/    │                  │                    │
  ├──────────────────────→│                  │                    │
  │                       │ 2. Forward       │                    │
  │                       ├─────────────────→│                    │
  │                       │                  │ 3. Check Auth      │
  │                       │                  │ (JWT Token)        │
  │                       │                  │                    │
  │                       │                  │ 4. Query           │
  │                       │                  ├───────────────────→│
  │                       │                  │                    │
  │                       │                  │ 5. Return Books    │
  │                       │                  │←───────────────────┤
  │                       │                  │                    │
  │                       │                  │ 6. Serialize JSON  │
  │                       │                  │                    │
  │                       │ 7. Response      │                    │
  │←──────────────────────┤←─────────────────┤                    │
  │                       │                  │                    │
  │ 8. Browser Renders    │                  │                    │
  │                       │                  │                    │
```

---

## 🎯 Files va Papkalar

### Docker Compose Files

```
docker-compose.yml
  ├─ web: Gunicorn + Django
  │   ├─ Port: 8000
  │   ├─ Volume: /code
  │   └─ Commands: migrations, collectstatic
  │
  ├─ nginx: Nginx Proxy
  │   ├─ Port: 80, 443
  │   ├─ SSL: /ssl/
  │   └─ Volume: static, media
  │
  ├─ db: PostgreSQL
  │   ├─ Port: 5432
  │   └─ Volume: postgres_data
  │
  └─ redis: Redis Cache
      ├─ Port: 6379
      └─ Volume: redis_data

Dockerfile
  ├─ FROM python:3.11-slim
  ├─ pip install requirements.txt
  ├─ ADD entrypoint.sh
  └─ CMD gunicorn

nginx.conf
  ├─ HTTP → HTTPS redirect (80 → 443)
  ├─ SSL certificates (cert.pem, key.pem)
  ├─ Static files location (/static/)
  ├─ Media files location (/media/)
  └─ Proxy pass: http://web:8000

entrypoint.sh
  ├─ Check database
  ├─ Run migrations
  ├─ Collect static
  ├─ Create cache table
  └─ Start gunicorn
```

---

## 🚀 Deploy Checklist

```
DigitalOcean Setup:
☐ Create Droplet (Ubuntu 22.04)
☐ Setup SSH key
☐ SSH into server

Server Preparation:
☐ apt update && upgrade
☐ Install Docker
☐ Install Docker Compose
☐ Install Git

Project Setup:
☐ git clone E-Library
☐ Copy .env.example → .env
☐ Update .env with domain & passwords

SSL Certificate:
☐ Install Certbot
☐ Get Let's Encrypt certificate
☐ Copy to /ssl/

Deploy:
☐ bash deploy.sh
☐ Create superuser
☐ Test https://yourdomain.com

Maintenance:
☐ Setup auto-renewal cron job
☐ Setup monitoring
☐ Backup database
```

---

## 🆘 Troubleshooting

| Muammo | Sabab | Yechim |
|--------|------|--------|
| `Connection refused` | Database xato | `docker-compose logs db` |
| `Port already in use` | Boshqa app | `lsof -i :PORT` → kill |
| `SSL certificate error` | Self-signed | Update cert from Let's Encrypt |
| `Static files not loading` | collectstatic | `docker-compose exec web python manage.py collectstatic` |
| `Module not found` | Requirements | `pip install -r requirements.txt` |
| `Database migration error` | Conflict | `docker-compose down -v` → restart |

---

## 📚 Qo'shimcha Ma'lumot

- [README.md](./README.md) - Batafsil qo'llanma
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Production deploy
- [QUICKSTART.md](./QUICKSTART.md) - Tez boshlash
- [Django Docs](https://docs.djangoproject.com)
- [Docker Docs](https://docs.docker.com)

---

**Rasm bilan tushuncha aniq bo'ldi inshalloh!**
