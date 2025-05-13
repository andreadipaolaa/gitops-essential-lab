FROM python:3.12-alpine

# Evitiamo problemi di TLS/SSL e timezone
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    TZ=UTC

WORKDIR /app

# Dipendenze (vuoto per questo esempio, ma lasciamo lo step per completezza)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia dell’app
COPY app.py .

ENTRYPOINT ["python", "app.py"]
