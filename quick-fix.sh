#!/bin/bash

# Quick Fix Script for DigitalOcean Deployment
# Foydalanish: bash quick-fix.sh

set -e

echo "================================================"
echo "E-Library Quick Fix"
echo "================================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Stop containers
echo -e "${YELLOW}🛑 Konteynerlarni to'xtatish...${NC}"
docker-compose down -v

# 2. Fix line endings
echo -e "${YELLOW}📝 Line endings tuzatish...${NC}"
sed -i 's/\r$//' entrypoint.sh
sed -i 's/\r$//' deploy.sh
sed -i 's/\r$//' setup-server.sh
sed -i 's/\r$//' health-check.sh
sed -i 's/\r$//' init-ssl.sh

# 3. Make sure scripts are executable
echo -e "${YELLOW}🔒 Permissions sozlash...${NC}"
chmod +x entrypoint.sh
chmod +x deploy.sh
chmod +x setup-server.sh
chmod +x health-check.sh
chmod +x init-ssl.sh

# 4. Rebuild and start
echo -e "${YELLOW}🔨 Docker image'larni rebuild qilish...${NC}"
docker-compose build --no-cache

echo -e "${YELLOW}🚀 Konteynerlarni ishga tushirish...${NC}"
docker-compose up -d

# 5. Wait for services to start
echo -e "${YELLOW}⏳ Servislar ishlamasini kutish (45 sekund)...${NC}"
sleep 45

# 6. Check status
echo -e "${YELLOW}📊 Status tekshirish...${NC}"
docker-compose ps

echo ""
echo -e "${GREEN}✅ Quick fix yakunlandi!${NC}"
echo ""
echo "Log'larni ko'rish:"
echo "docker-compose logs -f web"
echo ""
echo "Health check:"
echo "bash health-check.sh"
echo ""
