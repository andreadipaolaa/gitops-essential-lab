# Base image minimale con Nginx
FROM nginx:1.27-alpine

# Copia della pagina statica
COPY index.html /usr/share/nginx/html/index.html

# Espone la porta HTTP di default
EXPOSE 80

# Nginx parte già in foreground nell’immagine ufficiale (CMD default)
