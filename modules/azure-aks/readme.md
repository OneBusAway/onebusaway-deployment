# Deployment Guide for Azure AKS

Azure Kubernetes Service (AKS) is a managed Kubernetes service provided by Azure, it provides a wide range of features and integrations with other Azure services. This guide will show you how to deploy Onebusaway server on Azure AKS.

## Prerequisites

1. An Azure account, if you don't have one, you can create a free account [here](https://azure.microsoft.com/en-us/free/).
2. Azure CLI, you can install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
3. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).
4. Make sure you install *ALL* the prerequisites before you start the deployment.

## Steps

1. Clone this repository to your local machine, you can run
```bash
git clone
```

2. Change the directory to `modules/azure-aks`, you can use command
```bash
cd onebusaway-deployment/modules/azure-aks
```

3. Login to your Azure account using Azure CLI
```bash
az login
```

4. Initialize the project, this will download the necessary plugins and providers for the project
```bash
tofu init
```

5. Deploy the project
```bash
tofu apply
```

6. Configure kubectl to connect to the AKS cluster
```bash
az aks get-credentials --resource-group $(tofu output -raw resource_group_name) --name $(tofu output -raw aks_cluster_name)

# check context
kubectl config get-contexts
```

7. Access Kubernetes Dashboard
```bash
 az aks browse --resource-group $(tofu output -raw resource_group_name) --name $(tofu output -raw aks_cluster_name)
```

8. Install Ingress Nginx

Here is the [recommended way](https://kubernetes.github.io/ingress-nginx/deploy/#azure) to install Ingress Nginx on AKS:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/cloud/deploy.yaml
```

9. Configure your domain 

You should add a DNS record to your domain to point to the IP address of the Ingress Nginx controller. You can find the IP address by running:
```bash
kubectl get svc -n ingress-nginx
```
If you are using Cloudflare, you can follow the instructions [here](https://developers.cloudflare.com/dns/manage-dns-records/how-to/create-dns-records).

10. deploy OneBusAway server

Modify the `onebusaway/values.yaml` file to configure the application. You can find the parameters meaning in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/#deployment-parameters).
You can use this command to deploy the application:
```bash
helm install onebusaway ../../charts/onebusaway
```
Then you can check the status of the deployment by running:
```bash
kubectl get pods -n oba
```

11. Access the OneBusAway server

You can access the OneBusAway server by visiting the domain you configured in step 9.
