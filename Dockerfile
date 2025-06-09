# Étape 1: Build React
FROM node:18-alpine AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci --only=production
COPY frontend/ .
RUN npm run build

# Étape 2: Setup Python + FastAPI
FROM python:3.9-slim
WORKDIR /app

# Installer les dépendances Python
COPY backend/requirements.txt ./backend/
RUN pip install --no-cache-dir -r backend/requirements.txt

# Copier le backend
COPY backend/ ./backend/

# Copier le build React
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Variables d'environnement
ENV PYTHONPATH=/app/backend
ENV RAILWAY_ENVIRONMENT=true
ENV ENVIRONMENT=production

# Exposer le port
EXPOSE 8000

# Commande de démarrage
CMD ["python", "backend/app.py"]