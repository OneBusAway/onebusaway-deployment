# Kubernetes deployment guide

1. Install Kubernetes components

* Install Kubectl by following the instructions [here](https://kubernetes.io/docs/tasks/tools/). </br>
* Install Helm by following the instructions [here](https://helm.sh/docs/intro/install/).</br>
You should have the following output on your terminal:
```bash
$ kubectl version --client
Client Version: v1.29.1
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3

$ helm version
version.BuildInfo{Version:"v3.14.3", GitCommit:"f03cc04caaa8f6d7c3e67cf918929150cf6f3f12", GitTreeState:"clean", GoVersion:"go1.21.7"}
```
(Optional) Install k8s [lens](https://k8slens.dev/)  to manage your kubernetes cluster.

2. Install Ingress Nginx

RUN the following command to install Ingress Nginx:
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm install nginx-ingress ingress-nginx/ingress-nginx
```

3. Configure your domain

You should add a DNS record to your domain to point to the IP address of the Ingress Nginx controller. You can find the IP address by running:
```bash
kubectl get svc -n ingress-nginx
```

4. Configure the application

Modify the `charts/values.yaml` file to configure the application. You can find the parameters meaning in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/#deployment-parameters).

5. Deploy the application

You can use this command to deploy the application:
```bash
helm install onebusaway charts/
```
Then you can check the status of the deployment by running:
```bash
kubectl get pods -n oba
```
