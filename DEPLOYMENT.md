# DigitalOcean Deployment Guide

Bu qo'llanma Django REST Framework loyihangizni DigitalOcean ga Docker va Nginx bilan deploy qilish bo'yicha to'liq ko'rsatmalar beradi.

## 📋 Talab qilinadigan narsalar

- DigitalOcean akkaunt
- Domain nomi (DNS sozlamalari)
- SSH kalit
- Docker va Docker Compose o'rnatilgan server

## 🚀 Boshlang'ich sozlash

### 1. DigitalOcean Droplet yaratish

1. DigitalOcean konsolga kirish
2. "Create" tugmasini bosish
3. "Droplets" tanlash
4. Konfiguratsiya:
   - **Image**: Ubuntu 22.04 x64
   - **Size**: Starter Pack (minimal $5/oy)
   - **Region**: Sizga eng yaqin region
   - **Authentication**: SSH kalit qo'shish
   - **Hostname**: masalan `elibrary-server`

### 2. Server tayyorlash

```bash
# SSH orqali serverga ulanish
ssh root@YOUR_SERVER_IP

# Paketlarni yangilash
apt update && apt upgrade -y

# Docker o'rnatish
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Docker Compose o'rnatish
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Git o'rnatish
apt install -y git
```

### 3. Loyihani klonlash

```bash
# Loyihani klonlash
cd /opt
git clone https://github.com/YOUR_USERNAME/elibrary.git
cd elibrary

# .env faylini tayyorlash
cp .env.example .env
nano .env
```

### 4. .env faylini sozlash

Production uchun zarur bo'lgan o'zgaruvchilar:

```env
DEBUG=False
SECRET_KEY=django-insecure-GENERATE-NEW-KEY
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com
POSTGRES_PASSWORD=strong-password-min-20-chars
CORS_ALLOWED_ORIGINS=https://yourdomain.com
```

**Secret Key generatsiyasi:**
```bash
python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

## 🔐 SSL Sertifikat sozlash

### Let's Encrypt bilan bepul SSL sertifikat

```bash
# Certbot o'rnatish
apt install -y certbot

# Sertifikat olish (SSL papkasi yaratish)
mkdir -p ssl

# Vaqtincha HTTP server ishga tushirish
docker-compose up -d nginx

# Certbot bilan sertifikat olish
certbot certonly --webroot \
  --webroot-path /var/www/certbot \
  -d yourdomain.com \
  -d www.yourdomain.com

# Sertifikatlarni SSL papkasiga nusxalash
cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ssl/cert.pem
cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ssl/key.pem

# Xarakteristikalari
chmod 644 ssl/*
```

**ESLATMA:** Sertifikatlarni har 90 kunda yangilash kerak. Avtomatik yangilash uchun cron job qo'shing:

```bash
# Crontab redaksiyaga kirish
crontab -e

# Qo'shish (har kuni 2:00 da tekshirish)
0 2 * * * certbot renew --quiet && cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem /opt/elibrary/ssl/cert.pem && cp /etc/letsencrypt/live/yourdomain.com/privkey.pem /opt/elibrary/ssl/key.pem && docker restart elibrary_nginx
```

## 🐳 Docker bilan deploy

### Konteynerlarni ishga tushirish

```bash
# Loyiha papkasiga kirish
cd /opt/elibrary

# Konteynerlarni build qilish va ishga tushirish
docker-compose up -d

# Log'larni tekshirish
docker-compose logs -f

# Database migratsiyalarini tekshirish
docker-compose exec web python manage.py migrate --check
```

### Konteyner statusini tekshirish

```bash
# Barcha konteynerlar
docker-compose ps

# Bitta konteyner loglari
docker-compose logs web
docker-compose logs nginx
docker-compose logs db
```

## 📝 Kengaytirish va Texna'mahlash

### Django migrations ishlatish

```bash
# Yangi migratsiya yaratish
docker-compose exec web python manage.py makemigrations

# Migratsiyalarni qo'llash
docker-compose exec web python manage.py migrate

# Static fayllarni yig'ish
docker-compose exec web python manage.py collectstatic --noinput
```

### Superuser yaratish

```bash
docker-compose exec web python manage.py createsuperuser
```

### Bash shelli ochish

```bash
docker-compose exec web bash
```

## 🔄 Update va Backup

### Yangilash

```bash
cd /opt/elibrary

# Kodni yangilash
git pull origin main

# Konteynerlarni qayta build qilish
docker-compose down
docker-compose up -d

# Log'larni tekshirish
docker-compose logs -f web
```

### Backup

```bash
# PostgreSQL backup
docker-compose exec db pg_dump -U elibraryuser elibrary > backup_$(date +%Y%m%d_%H%M%S).sql

# Media fayllarini backup qilish
tar -czf media_backup_$(date +%Y%m%d_%H%M%S).tar.gz media/
```

## 📊 Monitoring va Tekshirish

### Sizning saytni tekshirish

```bash
# HTTPS ishlayotganini tekshirish
curl -I https://yourdomain.com

# Sertifikat o'qib ko'rish
echo | openssl s_client -servername yourdomain.com -connect yourdomain.com:443 2>/dev/null | openssl x509 -noout -dates
```

### API health check

```bash
curl https://yourdomain.com/api/health/
```

## 🛠️ Muammolarni hal qilish

### Konteyner ishlamayotgan bo'lsa

```bash
# Konteynerlarni restart qilish
docker-compose restart

# Barcha konteynerlarni to'xtatish va o'chirish
docker-compose down

# Qayta ishga tushirish
docker-compose up -d
```

### Database xatosi

```bash
# Database statusini tekshirish
docker-compose exec db pg_isready

# Database logs
docker-compose logs db
```

### Nginx xatosi

```bash
# Nginx konfiguratsiyasini tekshirish
docker-compose exec nginx nginx -t

# Nginx restart
docker-compose restart nginx
```

### PORT tayinlangan bo'lsa (Port already in use)

```bash
# PORT 80 va 443 dan foydalanadigan jarayonni topish
sudo lsof -i :80
sudo lsof -i :443

# Jarayonni o'ldirish (PID = jarayon ID si)
kill -9 PID
```

## 🔐 Security Best Practices

1. **SSH Kaliti:** Parol o'rniga faqat SSH kalitini ishlatish
2. **Firewall:** UFW orqali portlarni cheklash
3. **.env fayli:** Hech qachon Git'ga commit qilmasligi
4. **Secret Key:** Har safar yangi Secret Key generatsiya qilish
5. **HTTPS:** Har doim HTTPS ishlatish
6. **Regular Updates:** Tizimni va paketlarni tartibli yangilash

```bash
# UFW o'rnatish va sozlash
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
```

## 📞 Support va Ma'lumot

- Django Docs: https://docs.djangoproject.com
- Docker Docs: https://docs.docker.com
- DigitalOcean Community: https://www.digitalocean.com/community

## ✅ Checklist

- [ ] Server yaratildi
- [ ] Docker va Docker Compose o'rnatildi
- [ ] Loyiha klonlandi
- [ ] .env fayli konfiguratsiya qilindi
- [ ] SSL sertifikat olindi
- [ ] Konteynerlar ishga tushirildi
- [ ] Database migratsiyalari bajarildi
- [ ] Sayt HTTPS orqali ishlaydi
- [ ] Admin panel kirish ishlaydi
- [ ] API endpoints tekshirildi

---

Muammolar bo'lsa, docker-compose logs fayllarini tekshiring va muhim xatolarni ko'rib chiqing.
