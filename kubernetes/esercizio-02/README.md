# Esercizio K8s 2 – “Config & Scaling 🚀”

Gestisci **ConfigMap**, probe di salute e scaling automatico in Kubernetes partendo dal namespace `demo` usato nel primo esercizio.

---

## Obiettivo
1. Creare una **ConfigMap** `nginx-html` che contenga un file `index.html` personalizzato.    2. Aggiornare/creare un **Deployment** `nginx-deploy` con 2 repliche, montando la ConfigMap come volume in `/usr/share/nginx/html`.    3. Aggiungere **Readiness** e **Liveness** probe HTTP su `/`.    4. Esporre il Deployment tramite **Service** `nginx-svc` (ClusterIP).    5. Port-forward del Service su **8080** e verificare la pagina.    6. Scalare a 4 repliche con `kubectl scale` e verificare che tutti i Pod siano *Running*.

---

## Passi suggeriti

| # | Manifest / Comando | Azione |
|---|---------------------|--------|
| 1 | `configmap.yaml` | Crea ConfigMap |
| 2 | `deployment.yaml` | Deployment 2 repliche + probes |
| 3 | `service.yaml` | Service ClusterIP |
| 4 | Apply | `kubectl apply -f . -n demo` |
| 5 | Health | Verifica probes con `kubectl describe pod …` |
| 6 | Scaling | `kubectl scale deployment nginx-deploy --replicas=4 -n demo` |

---

## Struttura attesa

```
k8s-esercizio-02/
├── README.md
└── solution/
    ├── configmap.yaml
    ├── deployment.yaml
    └── service.yaml
```
