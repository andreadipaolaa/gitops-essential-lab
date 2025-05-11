# Esercizio K8s 3 – “Stateful Services & Persistence 💾”

Impara a deployare un database **stateful** con persistenza dei dati usando **StatefulSet**, **PersistentVolumeClaim** e **Secret**.

---

## Obiettivo
1. Ri‑usare il namespace `demo`.    
2. Creare un **Secret** `pg-secret` con la password del DB.    
3. Deployare lo **StatefulSet** `postgres-sts` con immagine `postgres:16-alpine` (1 replica).    
4. Richiedere un volume persistente (1 Gi) tramite `volumeClaimTemplates`.    
5. Esporre il DB con **Service** `postgres-svc` (ClusterIP, 5432).    
6. Inserire un record, distruggere il Pod e verificare che i dati persistano.

---

## Passi suggeriti

| # | Manifest / Comando | Azione |
|---|---------------------|--------|
| 1 | `secret.yaml`     | Crea la Secret con la password |
| 2 | `statefulset.yaml`| StatefulSet + PVC |
| 3 | `service.yaml`    | Service ClusterIP |
| 4 | Apply             | `kubectl apply -f . -n demo` |
| 5 | Wait              | `kubectl rollout status sts/postgres-sts -n demo` |
| 6 | Insert / Verify   | Usa `kubectl run ... psql` come descritto sotto |

### Inserimento e test dati

```bash
# Inserisci
kubectl run psql-client -n demo --rm -it --image=postgres:16-alpine --       psql -h postgres-svc -U demo -d demo_db -c       "CREATE TABLE hello(id serial PRIMARY KEY, msg text); INSERT INTO hello(msg) VALUES ('Hello K8s');"

# Elimina il pod PostgreSQL
kubectl delete pod -l app=postgres-demo -n demo

# Attendi nuovo pod Ready poi verifica
kubectl run psql-client -n demo --rm -it --image=postgres:16-alpine --       psql -h postgres-svc -U demo -d demo_db -c "SELECT * FROM hello;"
```

L’esercizio è superato se la riga è ancora presente ✅.

---

## Struttura directory

```
k8s-esercizio-03/
├── README.md
└── solution/
    ├── secret.yaml
    ├── statefulset.yaml
    └── service.yaml
```
