# Utilisez une image de base avec Node.js pour construire l'application Angular
FROM node:14 as builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le répertoire de travail
COPY . .

# Installer les dépendances
RUN npm install

# Construire l'application Angular
RUN npm run build --prod

# Utilisez une image de base légère avec Nginx pour héberger l'application Angular
FROM nginx:stable-alpine

# Copier les fichiers de build de l'application dans le répertoire de travail de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Copier la configuration nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80 pour accéder à l'application depuis l'extérieur du conteneur
EXPOSE 80

# Commande de démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]