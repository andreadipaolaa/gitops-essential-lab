# Immagine base leggera
FROM postgres:16-alpine

# Variabili d’ambiente di default
ENV POSTGRES_USER=demo         POSTGRES_PASSWORD=demo_pw         POSTGRES_DB=demo_db

# Script di inizializzazione
COPY init/ /docker-entrypoint-initdb.d/
