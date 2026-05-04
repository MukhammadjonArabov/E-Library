#!/bin/bash

# DigitalOcean Server Setup Script
# Foydalanish: sudo bash setup-server.sh

set -e

echo "================================================"
echo "DigitalOcean Server Setup"
echo "================================================"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}📦 Paketlarni yangilash...${NC}"
apt update && apt upgrade -y

echo -e "${YELLOW}📥 Zarur paketlarni o'rnatish...${NC}"
apt install -y \
    curl \
    wget \
    git \
    netcat \
    vim \
    htop \
    certbot

echo -e "${YELLOW}🐳 Docker o'rnatish...${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

echo -e "${YELLOW}🐳 Docker Compose o'rnatish...${NC}"
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d'"' -f4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -e "${YELLOW}🔒 UFW Firewall sozlash...${NC}"
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo -e "${YELLOW}📁 Loyiha uchun papka yaratish...${NC}"
mkdir -p /opt/elibrary
mkdir -p /opt/elibrary/ssl

echo -e "${YELLOW}🔐 SSL papkasi sozlamalari...${NC}"
chmod 755 /opt/elibrary/ssl

echo -e "${GREEN}✅ Server sozlamasi muvaffaqiyatli yakunlandi!${NC}"
echo ""
echo "================================================"
echo "Keyingi qadamlar:"
echo "================================================"
echo "1. Loyihani klonlash:"
echo "   cd /opt/elibrary"
echo "   git clone https://github.com/YOUR_USERNAME/elibrary.git ."
echo ""
echo "2. .env faylini sozlash:"
echo "   cp .env.example .env"
echo "   nano .env"
echo ""
echo "3. SSL sertifikat olish:"
echo "   certbot certonly --webroot -d yourdomain.com -d www.yourdomain.com"
echo ""
echo "4. Deployment skriptini ishga tushirish:"
echo "   bash deploy.sh"
echo ""
echo "================================================"

echo -e "${YELLOW}📋 Versiyalarni tekshirish...${NC}"
echo "Docker version: $(docker --version)"
echo "Docker Compose version: $(docker-compose --version)"
echo "UFW status: $(ufw status | head -1)"
