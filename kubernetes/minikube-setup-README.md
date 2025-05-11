# Guida rapida: installare Minikube in locale 🐳➡️🌀

Minikube avvia un singolo nodo Kubernetes nel tuo computer. È la soluzione più semplice per sperimentare in locale senza servizi cloud.

## 1 · Prerequisiti

| Strumento | Versione minima | Verifica |
|-----------|-----------------|----------|
| **Docker Engine** | 25.x | `docker version` |
| **kubectl** | 1.29.x | `kubectl version --client` |

---
## 2 · Installazione di Minikube

=== Mac (Homebrew) ===

```bash
brew install minikube
```

=== Linux (deb/rpm) ===

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

=== Windows (PowerShell + choco) ===

```powershell
choco install minikube
```

---
## 3 · Avvio del cluster

```bash
# Consigliato: 2 CPU e 4 GiB RAM
minikube start --cpus=2 --memory=4g
```

Il comando scarica la ISO della VM (o crea un container Docker) e configura `kubectl` per parlare con il cluster.

---
## 4 · Verifica

```bash
kubectl get nodes
```

Dovresti vedere un nodo `Ready` denominato `minikube`.

---
## 5 · Comandi utili

| Azione | Comando |
|--------|---------|
| Aprire dashboard grafica | `minikube dashboard` |
| Ottenere l’IP del cluster | `minikube ip` |
| Fermare il cluster | `minikube stop` |
| Eliminare il cluster | `minikube delete` |

---
## 6 · Aggiornare Minikube

Basta reinstallare con il package manager (brew/choco) oppure scaricare la nuova release e sovrascrivere il binario.

---
## 7 · Risorse utili

* Documentazione ufficiale: <https://minikube.sigs.k8s.io/docs/>
* FAQ troubleshooting: <https://minikube.sigs.k8s.io/docs/faq/>

<br>

Buon divertimento con Kubernetes in locale!
