# Étape de construction
FROM node:14 AS builder

WORKDIR /app

# Copie des fichiers package.json et package-lock.json (si vous en avez un)
COPY package*.json ./

# Installation des dépendances
RUN npm install

# Copie du reste des fichiers de l'application
COPY . .

# Construction de l'application
RUN npm run build -- --prod

# Étape de production
FROM nginx:alpine

# Copie du build de l'étape précédente dans le répertoire nginx public
COPY --from=builder /app/dist/crudtuto-Front /usr/share/nginx/html
# Exposition du port 4600
EXPOSE 4600

# Commande de démarrage pour Nginx
CMD ["nginx", "-g", "daemon off;"]