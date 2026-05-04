# 📖 E-Library Complete Setup Guide

Xush kelibsiz! Bu fayl barcha qo'llanmalarga o'rin ko'rsatadi.

---

## 🎯 Qaydan Boshlash Kerak?

### **1️⃣ Tez Boshlashni Xohlaysiz?**
👉 [**QUICKSTART.md**](./QUICKSTART.md) - 5 daqiqada ishga tushirish

### **2️⃣ Batafsil Tushintirish Kerak?**
👉 [**README.md**](./README.md) - Batafsil setup guide

### **3️⃣ Architecture'ni Tushunmoqchi?**
👉 [**ARCHITECTURE.md**](./ARCHITECTURE.md) - Rasm va diagrammalar

### **4️⃣ .env Faylini Sozlamoqchi?**
👉 [**ENV_SETUP.md**](./ENV_SETUP.md) - Environment variables guide

### **5️⃣ Production'ga Deploy qilmoqchi?**
👉 [**DEPLOYMENT.md**](./DEPLOYMENT.md) - DigitalOcean deploy guide

---

## 📚 Qo'llanmalar Index

| Fayl | Maqsali | Uchun |
|------|---------|-------|
| **QUICKSTART.md** | 5 daqiqada boshlash | Tezkorlari |
| **README.md** | Batafsil setup | Barcha detaillar |
| **ARCHITECTURE.md** | Sistema tuzilishi | Tushunch va Rasm |
| **ENV_SETUP.md** | Environment variables | .env file |
| **DEPLOYMENT.md** | Production deploy | DigitalOcean |
| **docker-compose.yml** | Docker config | Konteyner |
| **Dockerfile** | Build config | Web image |
| **nginx.conf** | Web server | Proxy/SSL |
| **entrypoint.sh** | Startup script | Container entry |
| **setup-server.sh** | Server setup | DigitalOcean prep |
| **deploy.sh** | Deploy script | One-click deploy |
| **health-check.sh** | Monitoring | System health |

---

## 🚀 Asosiy 3 Path

### **Path 1: Docker bilan (Eng Oson - Tavsiya)**
```
1. Docker Desktop o'rnatish
2. QUICKSTART.md ko'rish
3. docker-compose up --build
```

### **Path 2: Python venv bilan (Manual)**
```
1. Python 3.9+ o'rnatish
2. QUICKSTART.md ko'rish
3. python manage.py runserver
```

### **Path 3: Production (DigitalOcean)**
```
1. DigitalOcean Droplet yaratish
2. DEPLOYMENT.md'ni o'rish
3. bash deploy.sh
```

---

## 🔍 SSL Sertifikati Haqida (Tez Izoh)

### ❓ SSL Nima?

SSL - internet orqali xavfsiz ma'lumot uzatish.

```
🔒 HTTPS        ✅ Xavfsiz (Shifrlangan)
⚠️ HTTP         ❌ Xavfsiz emas (Tekis)
```

### 🎯 Nima Uchun Kerak?

1. **Shifrlash** - Password va ma'lumot himoyalash
2. **Autentifikatsiya** - Sayt haqiqiy ekanligini tasdiqlash
3. **Trust** - Foydalanuvchilar ishonish
4. **SEO** - Google HTTPS saytlarni birinchi joyda chiqaradi

### 🚀 Qanday Olish?

| Method | Qiymati | Joyi |
|--------|---------|-----|
| **Self-Signed** | Bepul | Testing |
| **Let's Encrypt** | Bepul | Production ✅ |
| **Paid SSL** | $50-500 | Corporate |

### ⚡ Quick Example

```bash
# Let's Encrypt orqali olish
certbot certonly --webroot -d yourdomain.com

# Sertifikatlarni kopya qilish
cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ssl/cert.pem
cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ssl/key.pem
```

**Batafsil**: [README.md](./README.md) → SSL Sertifikati bo'limi

---

## 📋 Complete Checklist

### Development Setup
- [ ] Git o'rnatish
- [ ] Docker Desktop o'rnatish yoki Python 3.9+
- [ ] Loyihani klonlash
- [ ] .env faylini qo'shish
- [ ] `docker-compose up` yoki `python manage.py runserver`
- [ ] http://localhost ochish
- [ ] Superuser yaratish
- [ ] Admin panel test qilish

### Production Setup
- [ ] DigitalOcean Droplet yaratish
- [ ] SSH key sozlash
- [ ] Server setup skriptini ishga tushirish
- [ ] Loyihani klonlash
- [ ] .env production values'ni qo'shish
- [ ] SSL sertifikat olish
- [ ] Deploy skriptini ishga tushirish
- [ ] DNS sozlash
- [ ] HTTPS tekshirish
- [ ] Monitoring sozlash

---

## 🆘 Tezkor Yechimlar

### ❌ "I don't know where to start"
→ [QUICKSTART.md](./QUICKSTART.md) o'qing (5 min)

### ❌ "What is SSL certificate?"
→ [README.md](./README.md#-ssl-sertifikati-batafsil-izohи) o'qing

### ❌ "How to setup .env?"
→ [ENV_SETUP.md](./ENV_SETUP.md) o'qing

### ❌ "How to deploy to production?"
→ [DEPLOYMENT.md](./DEPLOYMENT.md) o'qing

### ❌ "Container errors"
→ `docker-compose logs -f` buyrug'ini ishga tushiring

### ❌ "Database errors"
→ [README.md](./README.md#-muammolarni-hal-qilish) → Database bo'limi

---

## 📞 Yordam Olish

1. **Bu fayllarni o'qing**: QUICKSTART → README → DEPLOYMENT
2. **Log'larni ko'ring**: `docker-compose logs -f`
3. **Health check**: `bash health-check.sh`
4. **GitHub Issues**: [Savolni yozing](https://github.com/MukhammadjonArabov/E-Library/issues)

---

## 🎓 Learning Path

### Beginner
1. QUICKSTART.md (Boshlash)
2. README.md (Tushuntirish)
3. ARCHITECTURE.md (Rasm)

### Intermediate
1. DEPLOYMENT.md (Production)
2. ENV_SETUP.md (Configuration)
3. docker-compose.yml (Architecture)

### Advanced
1. Dockerfile (Image building)
2. nginx.conf (Web server)
3. entrypoint.sh (Startup logic)
4. Django docs (Code)

---

## 🎯 Use Cases by Role

### 👨‍💻 Developer (Dasturchi)
1. QUICKSTART.md → Docker boshlash
2. README.md → Local setup
3. Code → Start developing

### 🚀 DevOps/SysAdmin
1. DEPLOYMENT.md → Server setup
2. setup-server.sh → Automation
3. health-check.sh → Monitoring

### 🏢 Project Manager
1. ARCHITECTURE.md → System overview
2. README.md → Features
3. DEPLOYMENT.md → Timeline

---

## 📊 File Tuzilishi

```
E-Library/
│
├── 📖 Qo'llanmalar
│   ├── QUICKSTART.md          ← Tez boshlash (5 min)
│   ├── README.md              ← Batafsil guide (30 min)
│   ├── ARCHITECTURE.md        ← Rasm va diagrammar
│   ├── ENV_SETUP.md           ← Environment variables
│   ├── DEPLOYMENT.md          ← Production deploy
│   └── SETUP_GUIDE.md         ← Bu fayl
│
├── 🐳 Docker Configs
│   ├── docker-compose.yml     ← Services orchestration
│   ├── Dockerfile             ← Web image
│   ├── nginx.conf             ← Web server
│   ├── entrypoint.sh          ← Startup script
│   └── ssl/                   ← Certificates
│
├── 🚀 Deployment Scripts
│   ├── setup-server.sh        ← Server preparation
│   ├── deploy.sh              ← One-click deploy
│   ├── health-check.sh        ← Monitoring
│   └── init-ssl.sh            ← SSL setup
│
├── 🐍 Django Code
│   ├── config/                ← Django config
│   ├── bron/                  ← Main app
│   ├── manage.py              ← Django CLI
│   ├── requirements.txt       ← Dependencies
│   └── .env.example           ← Environment template
│
└── 📦 Utilities
    ├── .gitignore             ← Git ignore
    ├── .dockerignore          ← Docker ignore
    └── db.sqlite3             ← Local database
```

---

## ✅ Tugallanganini Tekshirish

### Development'da ishlab turgan bo'lsa
- [ ] http://localhost ochilishi kerak
- [ ] /admin/ ga kira olasiz
- [ ] /schema/swagger/ ko'rasan
- [ ] API respond qilmoqda

### Production'da deploy qilingan bo'lsa
- [ ] https://yourdomain.com ochilishi kerak
- [ ] 🔒 Secure badge ko'rinishiyaptimi?
- [ ] Admin panel ishlayaptimi?
- [ ] API respond qilmoqda?

---

## 🎉 Tayyor!

Endi sizga:
- ✅ Local Development muhiti (Docker yoki Python)
- ✅ Production Deploy muhiti (DigitalOcean)
- ✅ SSL/HTTPS Security
- ✅ Complete Documentation

**Tugadi! Boshlashga tayyor!**

---

**Sovol? [README.md](./README.md) yoki [QUICKSTART.md](./QUICKSTART.md) ko'ring**
