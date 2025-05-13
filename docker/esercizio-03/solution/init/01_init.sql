-- Viene eseguito solo al primo bootstrap del volume
CREATE TABLE IF NOT EXISTS hello (
    id  SERIAL PRIMARY KEY,
    msg TEXT NOT NULL
);
