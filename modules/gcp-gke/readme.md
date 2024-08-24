# Deployment Guide for Google Kubernetes Engine (GKE)

Google Kubernetes Engine (GKE) is a managed Kubernetes service provided by Google Cloud, offering a wide range of features and integrations with other Google Cloud services. This guide will show you how to deploy the OneBusAway server on GKE.

## Prerequisites

1. A Google Cloud account. If you don't have one, you can create a free account [here](https://cloud.google.com/free).
2. Google Cloud SDK (gcloud), which includes kubectl. You can install it by following the instructions [here](https://cloud.google.com/sdk/docs/install).
3. Opentofu, an open-source Terraform alternative. You can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).
4. Ensure that all prerequisites are installed before starting the deployment.

## Steps

1. Clone this repository to your local machine. You can run:
```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
```

2. Change the directory to `modules/gke`, using the command:
```bash
cd onebusaway-deployment/modules/gcp-gke
```

3. Configure your GCP credentials using the Google Cloud SDK, you can find the guide [here](https://cloud.google.com/docs/authentication/provide-credentials-adc).
```bash
gcloud auth application-default login
```

4. Initialize the project. This will download the necessary plugins and providers for the project:
```bash
tofu init
```

5. Configure the cluster by copying the example variables file and modifying it:
```bash
cp terraform.tfvars.example terraform.tfvars
```
Then modify the `terraform.tfvars` file to configure the cluster. You can find the meaning of each parameter in the `variables.tf` file.

6. Deploy the project:
```bash
tofu apply
```

7. Configure kubectl to connect to the GKE cluster:
```bash
gcloud container clusters get-credentials $(tofu output -raw gke_cluster_name) --region $(tofu output -raw gke_cluster_location)

# Check context
kubectl config get-contexts
```

8. Install Ingress Nginx:

Here is the [recommended way](https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke) to install Ingress Nginx on GKE:
```bash
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin \
  --user $(gcloud config get-value account)

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/cloud/deploy.yaml
```

9. Configure your domain:

You should add a DNS record to your domain to point to the IP address of the Ingress Nginx controller. You can find the IP address by running:
```bash
kubectl get svc -n ingress-nginx
```
If you are using Cloudflare, you can follow the instructions [here](https://developers.cloudflare.com/dns/manage-dns-records/how-to/create-dns-records).

10. Deploy OneBusAway server:

Modify the `onebusaway/values.yaml` file to configure the application. You can find the parameter meanings in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/#deployment-parameters).
You can use this command to deploy the application:
```bash
helm install onebusaway ../../charts/onebusaway
```
Then you can check the status of the deployment by running:
```bash
kubectl get pods -n oba
```

11. Access the OneBusAway server:

You can access the OneBusAway server by visiting the domain you configured in step 9.
