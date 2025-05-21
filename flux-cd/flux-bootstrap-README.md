# Flux CD – Bootstrap

Obiettivo  
1. Installare Flux CD su Minikube.  
2. Collegarlo a un repository GitHub **via PAT**.  
3. Prendere confidenza con i comandi di base di Flux.

⚠️ In questo primo step **non deployiamo applicazioni**: prepariamo il terreno per gli esercizi successivi.

---

## 1 · Prerequisiti

| Strumento     | Versione min. | Verifica                              |
|---------------|---------------|---------------------------------------|
| **Minikube**  | 1.32 (K8s ≥ 1.29) | `minikube version`                  |
| **kubectl**   | 1.29          | `kubectl version --client`            |
| **flux CLI**  | ≥ 2.4         | `flux --version`                      |
| **Git**       | 2.x           | `git --version`                       |
| **GitHub PAT**| scope `repo`  | genera in *GitHub ▸ Settings ▸ Tokens* |

---

## 2 · Cluster Minikube

```bash
minikube start --cpus=2 --memory=4g
kubectl get nodes            # deve risultare Ready
```

---

## 3 · Crea il repository GitHub

1. GitHub ▸ **New repository** → nome `flux-demo` (privato o pubblico).  
2. Lascia vuoto (niente README).  
3. Copia l’URL **HTTPS** (es. `https://github.com/<user>/flux-demo.git`).  

*(Con PAT GitHub, l’URL HTTPS è più semplice della chiave SSH).*

---

## 4 · Bootstrap di Flux con PAT

```bash
export GITHUB_TOKEN=<PAT>
export GITHUB_USER=<tuo_user_GH>

flux bootstrap github   --owner=$GITHUB_USER   --repository=flux-demo   --branch=main   --path=cluster/minikube   --token-auth   --personal
```

| Passo | Cosa succede                                             |
|------:|----------------------------------------------------------|
| 1 | Flux installa i controller nel namespace `flux-system`       |
| 2 | Spinge manifest base (`gotk-components.yaml`, ecc.) al repo  |
| 3 | Configura **GitRepository** e **Kustomization** per il path `cluster/minikube` con sync continuo |

Verifica lo stato:

```bash
watch flux get kustomizations -A
# "Ready=True" indica successo
```

---

## 5 · Comandi fondamentali di Flux

| Azione                                     | Comando                                     |
|--------------------------------------------|---------------------------------------------|
| Elenca le sorgenti Git                     | `flux get sources git -A`                   |
| Elenca le Kustomization                    | `flux get kustomizations -A`                |
| Forza una riconciliazione                  | `flux reconcile kustomization flux-system`  |
| Visualizza eventi di una risorsa           | `flux events --kind Kustomization --name flux-system -A` |
| Mostra log dei controller                  | `flux logs --level=info`                    |
| Sospendi / riprendi una Kustomization      | `flux suspend kustomization flux-system` ↔︎ `flux resume kustomization flux-system` |

> **Mini-esercizio**  
> 1. `flux suspend kustomization flux-system`  
> 2. Modifica (anche solo un commento) in `cluster/minikube/gotk-components.yaml`, push.  
> 3. Osserva che lo stato del cluster **non** cambia.  
> 4. `flux resume …` e riconcilia: le modifiche vengono applicate.

---

## 6 · Verifica finale

```bash
kubectl get pods -n flux-system          # tutti in Running/Ready
flux get sources git -A                  # Ready=True
flux get kustomizations -A               # Ready=True
```

Bootstrap completato ✅ — il cluster ora è **GitOps-enabled** e pronto per i prossimi esercizi.
