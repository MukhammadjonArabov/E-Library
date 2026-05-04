# 🚀 Tez O'rnatish Qo'llanmasi (Quick Start)

## ⏱️ 5 Daqiqada Ishga Tushirish

### 🐳 Docker bilan (Tavsiya)

```bash
# 1. Git va Docker Desktop'ni o'rnatish
# https://git-scm.com/download
# https://www.docker.com/products/docker-desktop

# 2. Loyihani klonlash
git clone https://github.com/MukhammadjonArabov/E-Library.git
cd E-Library

# 3. Ishga tushirish
docker-compose up --build

# 4. Boshqa terminal'da superuser yaratish
docker-compose exec web python manage.py createsuperuser

# 5. Brauzerda: http://localhost
```

**Tugadi! 🎉**

### 💻 Python bilan (Virtual Environment)

```bash
# 1. Python 3.9+ o'rnatish
# https://www.python.org/downloads

# 2. Loyihani klonlash
git clone https://github.com/MukhammadjonArabov/E-Library.git
cd E-Library

# 3. Virtual environment yaratish
python -m venv venv

# 4. Aktivlashni
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# 5. Dependents o'rnatish
pip install -r requirements.txt

# 6. Database sozlash
python manage.py migrate

# 7. Superuser yaratish
python manage.py createsuperuser

# 8. Ishga tushirish
python manage.py runserver

# 9. Brauzerda: http://127.0.0.1:8000
```

---

## 📍 Saytga Kirish

| Nima | URL |
|------|-----|
| API | http://localhost (Docker) yoki http://127.0.0.1:8000 (Python) |
| Admin | /admin/ |
| Swagger Docs | /schema/swagger/ |
| ReDoc Docs | /schema/redoc/ |

---

## 🎁 Admin Login

```
Username: (yuqorida kredit qilingan nom)
Password: (yuqorida kredit qilingan parol)
```

---

## 🐛 Xatoliklar

### ❌ "Docker not found"
→ Docker Desktop'ni o'rnatish kerak: https://docker.com/products/docker-desktop

### ❌ "Port already in use"
```bash
# Windows
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# macOS/Linux
lsof -i :8000
kill -9 <PID>
```

### ❌ "ModuleNotFoundError"
```bash
# Virtual environment'ni aktivlash kerak
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate
```

---

## 📖 Batafsil Qo'llanma

→ README.md'ni o'qing (Batafsil setup, SSL, Deploy)

---

**Savol bo'lsa, GitHub Issues'da savolshni qiling!**
