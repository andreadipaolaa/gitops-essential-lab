# Esercizio 1 – “Hello Docker”

In questo primo esercizio dovrai **containerizzare** una semplicissima applicazione Python.

### Obiettivo
Creare un’immagine Docker che, una volta avviata, stampi a schermo:

```
Hello, <NAME>! It is <ISO‑timestamp> UTC.
```

dove:

- `<NAME>` è il valore della variabile d’ambiente `NAME` (se non presente, usa `World`);
- `<ISO‑timestamp>` è la data/ora corrente in formato ISO 8601 (UTC).

### Passi suggeriti
1. **Clona** o **forka** questo repository e spostati nella cartella `esercizio‑01`.
2. Crea uno script `app.py` che implementi la logica descritta.
3. Scrivi un `Dockerfile` con i seguenti requisiti:
   - **Base image**: `python:3.12-alpine`
   - Copia lo script dentro `/app`
   - Imposta `WORKDIR /app`
   - Usa `ENTRYPOINT ["python", "app.py"]`
4. Costruisci l’immagine (ad es. `docker build -t hello-docker-app .`).
5. Avvia il container passando la variabile d’ambiente, per esempio:

   ```bash
   docker run --rm -e NAME=Mario hello-docker-app
   ```

   Dovresti vedere qualcosa come:

   ```
   Hello, Mario! It is 2025-05-07T14:32:01.123456 UTC.
   ```

### Criteri di valutazione
| Criterio | Requisito |
|----------|-----------|
| **Funzionalità** | Il messaggio stampato rispetta il formato richiesto |
| **Taglia immagine** | ≤ 50 MB (usa `--no-cache-dir`, Alpine, `.dockerignore`, ecc.) |
| **Pulizia** | Nessun file inutile nell’immagine (`__pycache__`, ecc.) |
| **Documentazione** | README chiaro su come costruire ed eseguire l’immagine |

> **Suggerimento**: prova con nomi diversi, senza variabile `NAME`, e controlla il peso finale con `docker images`.

Buon lavoro! :whale:
