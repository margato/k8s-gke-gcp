# K8s in Google Cloud Platform - Experiment

This is an experiment to see how K8S works in Google Cloud Platform (GCP), using Google Kubernetes Engine (GKE).

---

## Application
The `app` folder contains a simple application that exposes some commands through routes:

| Route | Description |
|--|--|
|`/products`| Outputs a list of dummy products. |
|`/debug`| Outputs the hostname and an environment variable value.|
|`/health`| Outputs "200 OK", used in health checks. |
|`/shutdown`| Forces the application to exit with code 0.|

This app is containerized and the image was pushed to Docker Hub: https://hub.docker.com/r/osvaldomargato/dummy-api-products/tags

### How to run
**Requirements:** go

```bash
cd ./app
make build
./output/api
```
---

## Kubernetes
The application is exposed through a basic service that points to a replica set.

### How to run
**Requirements:** minikube if running locally, kubectl.

Deploy manifests:
```bash
cd ./k8s
kubectl create ns ecommerce
kubectl config set-context --current --namespace=ecommerce
kubectl apply -f .
```

Check if pods are running:
```bash
kubectl get pods
```
---
## Cloud
The IaC tools used in this project was Terraform, and GCP was choosed as the cloud provider.

**Requirements:** GCP project with GKE API enabled, Terraform CLI, Terraform + GCP login configured.


**PS.:** Don't forget to change `project_id` in `./iac/envs/dev.tfvars`
### How to run
```bash
cd ./iac
make apply
```

Check if pods are running:
```bash
kubectl get pods
```

Get external IP from service:
```bash
kubectl get svc
```

Test connection with application:
```bash
curl http://<external-ip>/products
curl http://<external-ip>/debug
curl http://<external-ip>/health
curl http://<external-ip>/shutdown
```