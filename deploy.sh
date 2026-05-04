#!/bin/bash

# Production Deployment Script for DigitalOcean
# Foydalanish: bash deploy.sh

set -e

echo "================================================"
echo "Django REST Framework E-Library Deployment"
echo "================================================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Tekshirish: .env fayli mavjud ekanini
if [ ! -f .env ]; then
    echo -e "${RED}❌ .env fayli topilmadi!${NC}"
    echo "Qo'llanma:"
    echo "1. .env.example nusxalash: cp .env.example .env"
    echo "2. .env faylni tahrir qilish: nano .env"
    exit 1
fi

echo -e "${YELLOW}🔄 Konteynerlarni to'xtatish...${NC}"
docker-compose down

echo -e "${YELLOW}🔨 Yangi konteynerlarni build qilish...${NC}"
docker-compose build

echo -e "${YELLOW}🚀 Konteynerlarni ishga tushirish...${NC}"
docker-compose up -d

echo -e "${YELLOW}⏳ Konteynerlarning tayyorlandi kutish (10 soniya)...${NC}"
sleep 10

echo -e "${YELLOW}🔄 Database migratsiyalarini bajarish...${NC}"
docker-compose exec -T web python manage.py migrate

echo -e "${YELLOW}📦 Static fayllarni yig'ish...${NC}"
docker-compose exec -T web python manage.py collectstatic --noinput --clear

echo -e "${YELLOW}🗂️ Cache tablesi yaratish...${NC}"
docker-compose exec -T web python manage.py createcachetable 2>/dev/null || true

echo -e "${GREEN}✅ Deployment muvaffaqiyatli yakunlandi!${NC}"
echo ""
echo "================================================"
echo "Keyingi qadamlar:"
echo "================================================"
echo "1. Admin panelga kirish uchun superuser yaratish:"
echo "   docker-compose exec web python manage.py createsuperuser"
echo ""
echo "2. Saytni tekshirish:"
echo "   https://yourdomain.com"
echo ""
echo "3. Log'larni ko'rish:"
echo "   docker-compose logs -f web"
echo ""
echo "================================================"
