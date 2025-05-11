# Esercizio K8s 1 – “Hello Kubernetes 🌀”

Primo passo con Kubernetes: crea un **Deployment Nginx** in un namespace dedicato e verifica che la pagina di default sia accessibile tramite port‑forward.

---

## Obiettivo
1. Creare un namespace chiamato **`demo`**.    2. Deployare un **Deployment** `nginx-deploy` (1 replica) con immagine `nginx:1.27-alpine`.    3. Esporre il Deployment tramite un **Service** `nginx-svc` (ClusterIP) sulla porta 80.    4. Port‑forward del Service sulla porta **8080** dell’host e test con `curl`.

---

## Passi suggeriti

| Passo | Comando / Azione |
|-------|------------------|
| 1. Namespace          | `kubectl apply -f namespace.yaml` |
| 2. Deployment         | `kubectl apply -f deployment.yaml` |
| 3. Service            | `kubectl apply -f service.yaml` |
| 4. Rollout status     | `kubectl rollout status deployment/nginx-deploy -n demo` |
| 5. Port‑forward       | `kubectl port-forward svc/nginx-svc 8080:80 -n demo` |
| 6. Test pagina        | `curl http://localhost:8080` |

---

## Struttura attesa

```
k8s-esercizio-01/
├── README.md
└── solution/
    ├── namespace.yaml
    ├── deployment.yaml
    └── service.yaml
```
