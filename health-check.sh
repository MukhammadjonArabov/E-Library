#!/bin/bash

# Health Check Script
# Foydalanish: bash health-check.sh

echo "================================================"
echo "E-Library Health Check"
echo "================================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Docker konteynerlarni tekshirish
echo -e "${YELLOW}🐳 Docker Konteynerlar:${NC}"
docker-compose ps
echo ""

# Database tekshirish
echo -e "${YELLOW}🗄️  Database Status:${NC}"
if docker-compose exec -T db pg_isready -U elibraryuser &>/dev/null; then
    echo -e "${GREEN}✅ PostgreSQL ishlayapti${NC}"
else
    echo -e "${RED}❌ PostgreSQL xato${NC}"
fi
echo ""

# Redis tekshirish
echo -e "${YELLOW}💾 Redis Status:${NC}"
if docker-compose exec -T redis redis-cli ping &>/dev/null; then
    echo -e "${GREEN}✅ Redis ishlayapti${NC}"
else
    echo -e "${RED}❌ Redis xato${NC}"
fi
echo ""

# Web server tekshirish
echo -e "${YELLOW}🌐 Web Server Status:${NC}"
if docker-compose exec -T web python manage.py check &>/dev/null; then
    echo -e "${GREEN}✅ Django ishlayapti${NC}"
else
    echo -e "${RED}❌ Django xato${NC}"
fi
echo ""

# Disk maydoni
echo -e "${YELLOW}💾 Disk Maydoni:${NC}"
df -h | grep -E '^/dev/'
echo ""

# Memory
echo -e "${YELLOW}🧠 Memory:${NC}"
free -h | head -2
echo ""

# Network
echo -e "${YELLOW}🌍 Network:${NC}"
netstat -tuln | grep -E ':(80|443|8000|5432|6379)' || echo "Listening portlar topilmadi"
echo ""

# Log'larni tekshirish (oxirgi 10 error)
echo -e "${YELLOW}📝 Oxirgi Error Log'lar:${NC}"
docker-compose logs web | grep ERROR | tail -5 || echo "Error topilmadi"
echo ""

echo "================================================"
echo "Health check yakunlandi"
echo "================================================"
