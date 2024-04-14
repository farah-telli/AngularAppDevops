server {
    listen 80;
    server_name 192.168.50.4;

    root /usr/share/nginx/html; # Répertoire racine où se trouvent vos fichiers HTML

    location /SpringMVC/produit {
        proxy_pass http://172.20.10.6:8082/SpringMVC/produit;
    }

    
    location / {
        try_files $uri $uri/ /index.html; # Si une ressource n'est pas trouvée, servir index.html
    }

    
}