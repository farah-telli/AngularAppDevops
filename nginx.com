server {
    listen 80;
    server_name 172.20.10.6;

    root /usr/share/nginx/html; # Répertoire racine où se trouvent vos fichiers HTML

    location /SpringMVC/fournisseur {
        proxy_pass http://172.20.10.6:8082/SpringMVC/fournisseur;
    }

    
    location / {
        try_files $uri $uri/ /index.html; # Si une ressource n'est pas trouvée, servir index.html
    }

    
}