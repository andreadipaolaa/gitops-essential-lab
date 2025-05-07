# Esercizio 3 – “PostgreSQL persistente in Docker”

Containerizza PostgreSQL 16 e verifica che i dati restino disponibili dopo la ricreazione del container.

---

## Obiettivo
1. Avviare un container PostgreSQL 16 con:<br>
   • utente **demo**<br>
   • database **demo_db**
2. Creare una tabella ed inserire un record.
3. Fermare e ricreare il container **riutilizzando lo stesso volume**: il record deve essere ancora presente.

---

## Passi suggeriti

| # | Comando / Azione |
|---|------------------|
| **1. Build** | `docker build -t pg-demo .` |
| **2. Crea volume** | `docker volume create pgdata_demo` |
| **3. Run** | `docker run --rm -d --name pg-demo -p 5432:5432 -v pgdata_demo:/var/lib/postgresql/data pg-demo` |
| **4. Connettiti** | `docker exec -it pg-demo psql -U demo -d demo_db` |
| **5. Test persistenza** | `CREATE TABLE hello(id serial PRIMARY KEY, msg text);`<br>`INSERT INTO hello(msg) VALUES ('Hello from Docker 📦');`<br>`\q` e `docker stop pg-demo`<br>`docker run --rm -d --name pg-demo -p 5432:5432 -v pgdata_demo:/var/lib/postgresql/data pg-demo`<br>`SELECT * FROM hello;` → il record è presente. |

---

## Criteri di valutazione

| Criterio              | Requisito                                                         |
|-----------------------|-------------------------------------------------------------------|
| **Avvio container**   | PostgreSQL in ascolto sulla porta 5432                            |
| **Persistenza**       | I dati restano dopo stop / start con lo stesso volume             |
| **Pulizia**           | Immagine basata su `postgres:16-alpine`, taglia ≤ 80 MB           |
| **Documentazione**    | README chiaro su build, run, test                                 |

---

## Struttura attesa

```
esercizio‑03/
├── README.md
└── solution/
    ├── Dockerfile
    ├── init/
    │   └── 01_init.sql
    └── .dockerignore
```
