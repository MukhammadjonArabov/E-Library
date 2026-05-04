#!/bin/bash

# SSL Certificate Initialization Script
# Foydalanish: bash init-ssl.sh

set -e

echo "================================================"
echo "SSL Certificate Setup"
echo "================================================"

SSL_DIR="./ssl"
CERT_FILE="$SSL_DIR/cert.pem"
KEY_FILE="$SSL_DIR/key.pem"

# SSL papkasini yaratish
mkdir -p "$SSL_DIR"

# Agar sertifikat mavjud bo'lsa, o'tkazib yuborish
if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
    echo "✅ SSL sertifikatlari allaqachon mavjud"
    exit 0
fi

echo "📝 Self-signed SSL sertifikatini generatsiya qilish..."

# Self-signed sertifikat generatsiya
openssl req -x509 -newkey rsa:4096 -nodes \
    -out "$CERT_FILE" \
    -keyout "$KEY_FILE" \
    -days 365 \
    -subj "/C=UZ/ST=Tashkent/L=Tashkent/O=E-Library/CN=localhost"

echo "✅ Self-signed sertifikat yaratildi"
echo ""
echo "================================================"
echo "⚠️  ESLATMA: Self-signed sertifikat faqat testing uchun!"
echo "================================================"
echo ""
echo "Production uchun Let's Encrypt sertifikati oling:"
echo ""
echo "certbot certonly --webroot \\"
echo "  --webroot-path /var/www/certbot \\"
echo "  -d yourdomain.com \\"
echo "  -d www.yourdomain.com"
echo ""
echo "Keyin sertifikatlarni nusxalang:"
echo "cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ssl/cert.pem"
echo "cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ssl/key.pem"
echo ""
