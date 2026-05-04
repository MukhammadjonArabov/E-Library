# 🔧 DigitalOcean Deployment - Muammolar va Yechimlar

## ❌ Xato: "permission denied" entrypoint.sh

### Sabab
Windows'da .sh fayl CRLF (carriage return + line feed) line endings bilan saqlanadi, lekin Linux faqat LF talab qiladi.

### ✅ Yechim: Qayta Deploy Qilish

```bash
cd ~/E-Library

# 1. .sh fayllarni tuzatish (Windows line endings)
dos2unix entrypoint.sh deploy.sh setup-server.sh health-check.sh init-ssl.sh 2>/dev/null || \
sed -i 's/\r$//' entrypoint.sh deploy.sh setup-server.sh health-check.sh init-ssl.sh

# 2. Git'ga push qilish
git add entrypoint.sh deploy.sh
git commit -m "Fix: Line endings for shell scripts"
git push origin main

# 3. Qayta pull qilish serverda
cd ~/E-Library
git pull origin main

# 4. Konteynerlarni rebuild qilish
docker-compose down -v
docker-compose up --build

# ✅ Tayyor!
```

---

## ❌ Xato: "Cannot start service web"

### Debug qilish

```bash
# Konteyner loglarni ko'rish
docker-compose logs web

# Nginx loglarni ko'rish
docker-compose logs nginx

# Database loglarni ko'rish
docker-compose logs db

# Barcha konteynerlar
docker-compose ps
```

---

## ❌ Xato: "http://146.190.221.31 ishlamayapti"

### 🔍 Tekshirish

```bash
# 1. Nginx ishlayaptimi?
docker-compose exec nginx ps aux | grep nginx

# 2. Django web server ishlayaptimi?
docker-compose exec web ps aux | grep gunicorn

# 3. Database connected?
docker-compose exec web python manage.py check

# 4. Port'lar ishlayaptimi?
ss -tlnp | grep -E ':(80|443|8000|5432|6379)'

# 5. Firewall rules
sudo ufw status
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### 📊 Status Tekshirish

```bash
# Health check skriptini ishga tushirish
bash health-check.sh

# Docker stats (Memory, CPU, etc)
docker stats
```

---

## 🚀 Step-by-Step Fix

### 1️⃣ Kompyuterdan Server'ga Push qilish

**Windows PowerShell'da:**

```powershell
cd "d:\Django Rest Framework\E-Library"

# 1. Line endings tuzatish
Get-ChildItem -Path . -Filter "*.sh" | ForEach-Object {
    (Get-Content $_.FullName) -replace "`r`n", "`n" | Set-Content $_.FullName -Encoding UTF8
}

# 2. Git'ga qo'shish
git add .
git commit -m "Fix: Windows to Unix line endings for scripts"
git push origin main
```

### 2️⃣ DigitalOcean Server'da

```bash
# Server'ga SSH
ssh root@YOUR_SERVER_IP

# E-Library papkasiga o'tish
cd ~/E-Library

# Yangi code'ni pull qilish
git pull origin main

# Konteynerlarni to'liq restart qilish
docker-compose down -v
docker-compose up --build -d

# Loglarni ko'rish (real-time)
docker-compose logs -f web
```

### 3️⃣ Wait va Tekshirish

```bash
# Database migratsiyalari tuxtanguniga qadar kutish (30-40 sekund)
sleep 45

# Health check
bash health-check.sh

# Brauzerda tekshirish
curl -I http://YOUR_SERVER_IP
```

---

## 📋 Tugallanishi Checklist

```bash
# ✅ Barcha konteynerlar ishlayaptimi?
docker-compose ps
# Javob: Barcha qatorlarda "Up" bo'lishi kerak

# ✅ Database ready?
docker-compose exec db pg_isready -U elibraryuser
# Javob: "accepting connections"

# ✅ Redis ready?
docker-compose exec redis redis-cli ping
# Javob: "PONG"

# ✅ Nginx ishlayaptimi?
curl -I http://localhost
# Javob: "HTTP/1.1 200 OK" yoki "301 Moved Permanently" (HTTPS redirect)

# ✅ Django migrations complete?
docker-compose exec web python manage.py migrate --check
# Javob: "It is not necessary to install release notes"
```

---

## 🌐 HTTPS Sozlash (SSL)

### If Using Self-Signed (Testing)

```bash
# 1. Self-signed sertifikat yaratish
mkdir -p ssl
openssl req -x509 -newkey rsa:4096 -nodes \
    -out ssl/cert.pem \
    -keyout ssl/key.pem \
    -days 365 \
    -subj "/C=UZ/ST=Tashkent/L=Tashkent/O=E-Library/CN=localhost"

# 2. Nginx restart
docker-compose restart nginx

# 3. Tekshirish
curl -k -I https://YOUR_SERVER_IP
```

### If Using Let's Encrypt (Production)

```bash
# 1. SSL sertifikat olish
sudo certbot certonly --standalone \
    -d yourdomain.com \
    -d www.yourdomain.com

# 2. Sertifikatlarni kopya qilish
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ~/E-Library/ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ~/E-Library/ssl/key.pem
sudo chown $USER:$USER ~/E-Library/ssl/cert.pem ~/E-Library/ssl/key.pem

# 3. Nginx restart
docker-compose restart nginx

# 4. Tekshirish
curl -I https://yourdomain.com
```

---

## 🔐 Security - Firewall Rules

```bash
# UFW ni enable qilish
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Portlarni allow qilish
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS
sudo ufw enable

# Status ko'rish
sudo ufw status
```

---

## 💾 Backup va Restore

### Database Backup

```bash
# Backup yaratish
docker-compose exec db pg_dump -U elibraryuser elibrary > backup_$(date +%Y%m%d_%H%M%S).sql

# Backup'dan restore qilish
docker-compose exec db psql -U elibraryuser elibrary < backup_YYYYMMDD_HHMMSS.sql

# S3'ga backup (optional)
aws s3 cp backup.sql s3://your-bucket/backups/
```

### Media va Static Files Backup

```bash
# Backup qilish
tar -czf media_backup_$(date +%Y%m%d_%H%M%S).tar.gz media/
tar -czf static_backup_$(date +%Y%m%d_%H%M%S).tar.gz staticfiles/

# Restore qilish
tar -xzf media_backup.tar.gz
tar -xzf static_backup.tar.gz
```

---

## 📊 Monitoring va Logging

### Real-time Logs

```bash
# Web application logs
docker-compose logs -f web

# Nginx access logs
docker-compose logs -f nginx

# Database logs
docker-compose logs -f db

# All services
docker-compose logs -f
```

### Disk Space

```bash
# Disk usage ko'rish
df -h

# Docker images size
docker images --format "table {{.Repository}}\t{{.Size}}"

# Unused Docker data o'chirish
docker system prune -a --volumes
```

---

## 🔄 Updates va Yangilash

### Django Dependencies Yangilash

```bash
# requirements.txt'ni yangilash
pip install --upgrade pip
pip install -U -r requirements.txt

# Yangi requirements.txt'ni save qilish
pip freeze > requirements.txt

# Git'ga push qilish
git add requirements.txt
git commit -m "Update: Django packages"
git push origin main
```

### Container Images Yangilash

```bash
# Docker images'larni yangilash
docker-compose pull

# Qayta build va restart
docker-compose down
docker-compose up --build -d
```

---

## 🎯 Quick Commands Reference

```bash
# Qayta deploy qilish
cd ~/E-Library && docker-compose down && docker-compose up --build -d

# Logs ko'rish
docker-compose logs -f web

# Superuser yaratish
docker-compose exec web python manage.py createsuperuser

# Static files collect
docker-compose exec web python manage.py collectstatic --noinput

# Database shell
docker-compose exec web python manage.py shell

# Django check
docker-compose exec web python manage.py check

# Server restart
docker-compose restart

# Full restart (careful!)
docker-compose down -v && docker-compose up --build -d
```

---

## 📞 Emergency Procedures

### Agar hammasi ishlamasa

```bash
# 1. Diagnostika ishga tushirish
bash health-check.sh

# 2. Konteynerlarni o'chirish
docker-compose down -v

# 3. Qayta build qilish
docker-compose build --no-cache

# 4. Qayta ishga tushirish
docker-compose up -d

# 5. Logs ko'rish
docker-compose logs -f web
```

### Agar Django error bo'lsa

```bash
# 1. Container'ga kirish
docker-compose exec web bash

# 2. Django check qilish
python manage.py check

# 3. Migration'larni tekshirish
python manage.py migrate --check

# 4. Static files'larni collect qilish
python manage.py collectstatic --noinput
```

---

**Muammo tirishan bo'lsangiz, health-check.sh skriptini ishga tushiring!**

```bash
bash health-check.sh
```

Bu sizga tizim holati haqida to'liq ma'lumot beradi.
