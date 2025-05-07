# Esercizio 2 – “Static Web Server con Nginx”

Containerizza un semplice web‑server **Nginx** che restituisce una pagina HTML statica.

---

## Obiettivo
Avviando il container e pubblicando la porta sull’host, visitando `http://localhost:8080/` dovrai ottenere:

```
Hello from Docker! 🐳
```

---

## Passi suggeriti

1. Clona o forka il repo e spostati in `esercizio‑02`.
2. Crea un file `index.html` con il testo richiesto (o quello che preferisci).
3. Scrivi un `Dockerfile` che:
   - utilizzi come base `nginx:1.27-alpine`;
   - copi `index.html` in `/usr/share/nginx/html/`;
   - esponga la porta `80` (interna).
4. Costruisci l’immagine:

   ```bash
   docker build -t static-web .
   ```

5. Avvia il container esponendo la porta 80 interna sulla 8080 dell’host:

   ```bash
   docker run --rm -p 8080:80 static-web
   ```

6. Apri `http://localhost:8080` dal browser o con `curl`.

---

## Struttura attesa

```
esercizio‑02/
├── README.md
└── solution/
    ├── Dockerfile
    ├── index.html
```
