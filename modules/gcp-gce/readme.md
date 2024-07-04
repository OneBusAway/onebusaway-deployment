# Deployment Guide for Google Cloud Platform (GCP) Compute Engine

Google Cloud Platform (GCP) Compute Engine is a good choice for deploying the Onebusaway server. It provides a wide range of instance types and sizes, and you can choose the best one for your use case. This guide will show you how to deploy the Onebusaway server on GCP Compute Engine.

## Prerequisites

1. A GCP account, if you don't have one, you can create a free account [here](https://cloud.google.com/free).

2. Google Cloud SDK, you can install it by following the instructions [here](https://cloud.google.com/sdk/docs/install).

3. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Make sure you install *ALL* the prerequisites before you start the deployment.

## Steps

1. Clone this repository to your local machine, you can run
```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
```

2. Change the directory to `modules/gcp-gce`, you can use the command
```bash
cd onebusaway-deployment/modules/gcp-gce
```

3. Configure your GCP credentials using the Google Cloud SDK, you can find the guide [here](https://cloud.google.com/docs/authentication/provide-credentials-adc).
```bash
gcloud auth application-default login
```

4. Initialize the project, this will download the necessary plugins and providers for the project
```bash
tofu init
```

5. Create your custom `.env` file by copying the `.env.example` file, you can find parameters meaning in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/)
```bash
cp .env.example .env
```

6. Modify the `.env` and `variables.tf` file according to your needs. You can modify `DOMAIN` to your own domain, this will be used to generate an SSL certificate by [Caddy](https://caddyserver.com/). If you want to configure your own certs instead of automatic HTTPS, you can leave `caddy` blank. You should also check the `main.tf` file to make sure it works with your OS.

7. Deploy the project
```bash
tofu apply
```

8. Tofu will automatically generate SSH key pairs in the `ssh` folder, you can connect to the server using `ssh -i ./ssh/id_rsa <username>@<instance_ip>`.

9. After the deployment is finished, you need to wait a few minutes to let the server start. You can access the Onebusaway server by visiting `http://<instance_ip>:8080`. You can find the instance IP in the GCP Management Console.

10. (optional) If you configured your own domain, you should go to your domain provider and add an A record pointing to the instance IP. For example, if you use Cloudflare, you can follow the instructions [here](https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare). Caddy will configure certs based on the record. You should be able to visit your server by visiting `https://<your_domain>` after a few minutes.

## Clean up
If you want to shut down the server and clean up the resources, you can run the following command
```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the Compute Engine instance, network, SSH key pairs, and other resources.

## Conclusion
This guide shows you how to deploy the Onebusaway server on GCP Compute Engine using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.
