# Deployment Guide for Azure Linux VM

Azure VM is a good choice for deploying Onebusaway server, it provides a wide range of VM types and sizes, and you can choose the best one for your use case. This guide will show you how to deploy Onebusaway server on Azure Linux VM.

## Prerequisites

1. An Azure account, if you don't have one, you can create a free account [here](https://azure.microsoft.com/en-us/free/).

2. Azure CLI, you can install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

3. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Make sure you install *ALL* the prerequisites before you start the deployment.
## Steps

1. Clone this repository to your local machine, you can run
```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
```

2. Change the directory to `azure/vm`, you can use command
```bash
cd onebusaway-deployment/azure/vm
```
3. Login to your Azure account using Azure CLI
```bash
az login
```

4. Initialize the project, this will download the necessary plugins and providers for the project
```bash
tofu init
```

5. Create your custom `.env` file by copying the `.env.example` file, you can find parameters meaning in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/)
```bash
cp .env.example .env
```

6. Modify the `.env` file according to your needs. You can modify `DOMAIN` to your own domain, this will be used to generate SSL certificate by Caddy. We use password here instead of ssh pairs, you can modify `admin_password` to your own password in `variables.tf`, if you don't want to config your own certs instead of automatic HTTPS, you can leave `caddy` blank.

7. Deploy the project
```bash
tofu apply
```

8. After the deployment is finished, you need to wait a few minutes to let server start, you can access the Onebusaway server by visiting `http://<server_ip>:8080`, you can find the server IP in the Azure Portal.

10. (optional) If you configured your own domain, you should go to your domain provider and add an A record pointing to the server IP, for example, if you use Cloudflare, you can follow the instructions [here](https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare), Caddy will configure certs based on the record, you should be able to visit your server by visiting `https://<your_domain>` after a few minutes.

## Clean up
If you want to shut down the server and clean up the resources, you can run the following command
```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the VM, network, and other resources.

## Conclusion
This guide shows you how to deploy Onebusaway server on Azure Linux VM using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.
