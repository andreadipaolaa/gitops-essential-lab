# Helm – “All-in-One Nginx Chart” 🛠️🚀

In questo esercizio creerai e personalizzerai un **chart Helm** che incapsula l’intero stack Nginx visto finora:

| Risorsa K8s                | Scopo                                              |
|----------------------------|----------------------------------------------------|
| **ConfigMap**              | Fornire `index.html` personalizzato                |
| **Deployment**             | Gestire i Pod Nginx                                |
| **Service**                | Esporre i Pod a livello cluster                    |
| **HorizontalPodAutoscaler**| Scalare da 2 → 5 repliche al 50 % CPU              |
| **Ingress** (facoltativo)  | Pubblicare l’app su `demo.local`                   |

> Non conosci Helm? Nessun problema: le istruzioni ti guidano passo‑passo.

---

## 0 – Ripasso velocissimo su Helm

| Concetto   | Significato                                                   |
|------------|--------------------------------------------------------------|
| **Chart**  | Directory con template YAML + `values.yaml` + `Chart.yaml`    |
| **Template** | Variabili prese da `values.yaml`          |
| **Release**  | Un’installazione del chart nel cluster                      |

Comandi base:

```bash
helm create <nome-chart>   # scaffolding
helm lint <dir-chart>      # controlla errori
helm install <rel> <dir>   # installa
helm upgrade <rel> <dir>   # applica modifiche
helm uninstall <rel>       # rimuove
```

---

## 1 – Preparazione

```bash
git clone <repo_corrente>
cd helm-esercizio        # (creala se non esiste)

# Scaffold di partenza
helm create nginx-allinone
cd nginx-allinone
```

### Pulisci lo scaffold

```bash
# Manteniamo SOLO ciò che serve
rm templates/{hpa.yaml,ingress.yaml,NOTES.txt,serviceaccount.yaml,tests/*}
```

---

## 2 – Obiettivi del chart

| Variabile in `values.yaml`          | Default | Descrizione                           |
|------------------------------------|---------|---------------------------------------|
| `replicaCount`                     | 2       | Repliche iniziali del Deployment      |
| `image.repository` / `image.tag`   | `nginx` / `1.27-alpine` | Immagine Docker |
| `service.port`                     | 80      | Porta esposta dal Service             |
| `ingress.enabled`                  | `false` | Abilitare o meno l’Ingress            |
| `ingress.host`                     | `demo.local` | Hostname Ingress                   |
| `hpa.enabled`                      | `true`  | Abilitare o meno l’HPA               |
| `hpa.minReplicas / maxReplicas`    | 2 / 5   | Range di scaling                      |
| `hpa.cpu.targetPercentage`         | 50      | Soglia di utilizzo CPU                |
| `html.message`                     | "Hello from Helm 🚀" | Messaggio nella pagina |

---

## 3 – Modifica dei template

1. **`templates/configmap.yaml`** – Contiene l’`index.html` con `{{ .Values.html.message }}`.
2. **`templates/deployment.yaml`** – Usa `.Values.replicaCount`, monta la ConfigMap, include le risorse.
3. **`templates/service.yaml`** – Porta dinamica da `.Values.service.port`.
4. **`templates/hpa.yaml`** – Condizionale su `.Values.hpa.enabled`.
5. **`templates/ingress.yaml`** – Condizionale su `.Values.ingress.enabled`.

Riutilizza le funzioni in `_helpers.tpl` per `fullname` e `labels`.

---

## 4 – Test locale

```bash
helm lint .

# Installa di default nel namespace demo
helm install nginx-hello . -n demo --create-namespace

# Port‑forward per il test
kubectl port-forward svc/nginx-hello 8080:80 -n demo &
curl http://localhost:8080    # → Hello from Helm 🚀
```

---

## 5 – Esperimenti guidati

| Esperimento           | Comando                                                                           | Osserva |
|-----------------------|-----------------------------------------------------------------------------------|---------|
| Cambia messaggio      | `helm upgrade nginx-hello . -n demo --set html.message="Ciao dal chart 🌟"`     | Pagina aggiornata |
| Scala manualmente     | `helm upgrade nginx-hello . -n demo --set replicaCount=4`                         | 4 Pod Running |
| Disattiva HPA         | `helm upgrade nginx-hello . -n demo --set hpa.enabled=false`                      | HPA rimosso |
| Abilita Ingress       | `helm upgrade nginx-hello . -n demo -f ingress-values.yaml`                       | Accesso via `demo.local` |

*Esempio `ingress-values.yaml`:*

```yaml
ingress:
  enabled: true
  host: demo.local
```

---

## 6 – Pulizia

```bash
helm uninstall nginx-hello -n demo
```

---

## 7 – Criteri di valutazione

| Criterio                    | Requisito                                           |
|-----------------------------|-----------------------------------------------------|
| **`helm lint` senza errori**| Nessun WARNING/ERROR                                |
| **Parametri funzionanti**   | Variabili modificabili con `--set` / `-f`           |
| **HPA condizionale**        | Creato solo se `hpa.enabled` è `true`               |
| **Ingress condizionale**    | Creato solo se `ingress.enabled` è `true`           |
| **Upgrade idempotente**     | Più `helm upgrade` non causano conflitti            |
| **Uninstall pulito**        | Nessuna risorsa residua dopo `helm uninstall`       |

---

## 8 – Struttura directory finale

```
helm-esercizio/
├── README.md
└── nginx-allinone/
    ├── Chart.yaml
    ├── values.yaml
    ├── .helmignore
    └── templates/
        ├── _helpers.tpl
        ├── configmap.yaml
        ├── deployment.yaml
        ├── service.yaml
        ├── hpa.yaml        # creato se abilitato
        └── ingress.yaml    # creato se abilitato
```

---

> 🔍 **Sfida facoltativa**  
> Pubblica il chart in un tuo repository (GitHub Pages o S3) e installalo con:
> ```bash
> helm repo add myrepo https://<tuo-site>/charts
> helm install nginx-hello myrepo/nginx-allinone -n demo
> ```
