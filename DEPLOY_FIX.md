# 🚀 DigitalOcean Deploy - Tez Tuzatish

## ❌ Muammo Nima Edi?

```
ERROR: exec: "/code/entrypoint.sh": permission denied
```

**Sabab**: Windows'da `.sh` fayllar Windows line endings (CRLF) bilan saqlanadi, lekin Linux faqat Unix line endings (LF) talab qiladi.

---

## ✅ Tuzatish (Server'da)

### 1️⃣ SSH'ga Kirishni Tekshiring

```bash
ssh root@YOUR_SERVER_IP
cd ~/E-Library
```

### 2️⃣ Eng Oson - Quick Fix Script

```bash
bash quick-fix.sh
```

**Bu script avtomatik:**
- ✅ Konteynerlarni to'xtatadi
- ✅ Line ending'larni tuzatadi  
- ✅ Permissions sozlaydi
- ✅ Docker build qiladi
- ✅ Konteynerlarni restart qiladi

### 3️⃣ Yoki Manual Tuzatish

```bash
# 1. Konteynerlarni to'xtatish
docker-compose down -v

# 2. Line ending'larni tuzatish
sed -i 's/\r$//' entrypoint.sh deploy.sh setup-server.sh health-check.sh init-ssl.sh

# 3. Permissions
chmod +x *.sh

# 4. Rebuild and restart
docker-compose build --no-cache
docker-compose up -d

# 5. Wait 45 seconds
sleep 45

# 6. Check status
docker-compose ps
```

---

## 🔍 Tekshirish

### Konteynerlar Ishlayaptimi?

```bash
docker-compose ps
```

**Kutilgan Natija:**
```
NAME              STATUS
elibrary_db       Up (healthy)
elibrary_redis    Up (healthy)
elibrary_web      Up
elibrary_nginx    Up
```

### Logs Ko'rish

```bash
# Web application logs
docker-compose logs -f web

# Nginx logs
docker-compose logs -f nginx

# Database logs
docker-compose logs -f db
```

### Saytni Test Qilish

```bash
# Brauzerda yoki terminal'da:
curl -I http://YOUR_SERVER_IP

# Kutilgan Javob:
# HTTP/1.1 200 OK
```

---

## 🌐 Brauzerda Tekshirish

1. **Browser'ni Oching**
   ```
   http://YOUR_SERVER_IP
   ```

2. **Admin Panel'ga Kirish**
   ```
   http://YOUR_SERVER_IP/admin/
   Username: (yuqorida kredit qilingan)
   Password: (yuqorida kredit qilingan)
   ```

3. **API Documentation**
   ```
   http://YOUR_SERVER_IP/schema/swagger/
   ```

---

## 🔐 SSL Certificate Qo'shish (Ixtiyori)

**Self-signed sertifikat (Testing):**

```bash
mkdir -p ssl

openssl req -x509 -newkey rsa:4096 -nodes \
    -out ssl/cert.pem \
    -keyout ssl/key.pem \
    -days 365 \
    -subj "/C=UZ/ST=Tashkent/L=Tashkent/O=E-Library/CN=localhost"

docker-compose restart nginx
```

**Let's Encrypt (Production):**

```bash
sudo certbot certonly --standalone \
    -d yourdomain.com \
    -d www.yourdomain.com

sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ~/E-Library/ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ~/E-Library/ssl/key.pem

docker-compose restart nginx
```

---

## 📝 Local Kompyuterdan Server'ga Push Qilish

**Agar kod'ni yangilagan bo'lsangiz:**

```bash
# Windows PowerShell'da
cd "d:\Django Rest Framework\E-Library"

# Git'ga qo'shish
git add .
git commit -m "Fix: Deploy issues"
git push origin main

# Server'da
cd ~/E-Library
git pull origin main
bash quick-fix.sh
```

---

## 🆘 Agar Hali Muammo Bo'lsa

```bash
# 1. Health check
bash health-check.sh

# 2. Barcha logs
docker-compose logs

# 3. Full restart
docker-compose down -v
docker-compose up --build -d

# 4. Uning ardidan
sleep 45
bash health-check.sh
```

---

## 📊 Expected Output

Muvaffaqiyatli bo'lganda:

```bash
$ docker-compose ps
NAME              COMMAND                 SERVICE  STATUS
elibrary_db       postgres               db       Up (healthy)
elibrary_redis    redis-server           redis    Up (healthy)  
elibrary_web      /code/entrypoint.sh    web      Up
elibrary_nginx    nginx -g daemon off    nginx    Up
```

Va:

```bash
$ curl -I http://YOUR_SERVER_IP
HTTP/1.1 200 OK
```

---

## ✨ Tugadi!

Agar hala muammo bo'lsa: `docker-compose logs web` ko'ring

