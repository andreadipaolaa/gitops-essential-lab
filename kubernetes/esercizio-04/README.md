# Esercizio K8s 4 – “Autoscaling & Ingress 🌐⚖️”

Metti insieme autoscaling orizzontale e ingress per esporre un’app stateless scalabile.

---

## Obiettivo
1. Deployment **web-deploy** (2 repliche) con `nginx:1.27-alpine` e *requests* 50 m CPU / 64 Mi RAM.    
2. Service **web-svc** (ClusterIP, 80).    
3. Ingress **web-ing** host `demo.local` ✚ regola path `/` → `web-svc`.    
4. HPA **web-hpa** 2–5 repliche, target 50 % CPU.    
5. Genera carico e verifica che le repliche salgano sopra 2, poi tornino a 2 when idle.

> Assicurati di avere **metrics‑server** e **NGINX Ingress Controller** installati sul cluster.    > Aggiungi nel tuo `/etc/hosts` la riga: `127.0.0.1  demo.local` (o l’IP del tuo ingress).

---

## Passi rapidi

| # | Manifest / Comando | Azione |
|---|--------------------|--------|
| 1 | `deployment.yaml` | Deployment con richieste risorse |
| 2 | `service.yaml`    | Service ClusterIP |
| 3 | `ingress.yaml`    | Host `demo.local` |
| 4 | `hpa.yaml`        | HPA CPU 50 % |
| 5 | Apply             | `kubectl apply -f . -n demo` |
| 6 | Test Ingress      | `curl http://demo.local` |
| 7 | Load test         | vedi README sezione *Carico* |
| 8 | Watch scaling     | `watch kubectl get hpa,pods -n demo` |

---

## Carico di prova

```bash
kubectl run -i --tty load --rm --image=busybox -n demo -- /bin/sh -c       "while true; do wget -q -O- http://web-svc; done"
```

Arresta il pod `load` con `Ctrl+C` e osserva l’HPA tornare a 2 repliche.

---

## Criteri di valutazione

| Criterio            | Requisito                                   |
|---------------------|---------------------------------------------|
| **Ingress ok**      | `curl http://demo.local` restituisce 200    |
| **HPA scala**       | Aumenta repliche con carico, diminuisce dopo|
| **Resource limits** | Requests/limits presenti                    |
| **Pulizia YAML**    | Manifests ordinati e commentati             |

---

## Struttura

```
k8s-esercizio-04/
├── README.md
└── solution/
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    └── hpa.yaml
```
