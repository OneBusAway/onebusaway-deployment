# Deployment Guide for DigitalOcean Droplets

DigitalOcean Droplets provide a reliable and cost-effective solution for deploying the OneBusAway server. This guide will walk you through deploying the OneBusAway server on a DigitalOcean Droplet using Opentofu, an open-source Terraform alternative.

## Prerequisites

1. A DigitalOcean account. If you don't have one, you can sign up [here](https://cloud.digitalocean.com/registrations/new).

2. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

3. Make sure you install *ALL* the prerequisites before you start the deployment.

## Steps

1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/OneBusAway/onebusaway-deployment.git
    ```

2. Change the directory to `modules/digitalocean-droplet`:
    ```bash
    cd onebusaway-deployment/modules/digitalocean-droplets
    ```

3. Initialize the project, which will download the necessary plugins and providers:
    ```bash
    tofu init
    ```

4. Create a `terraform.tfvars` file by copying the `terraform.tfvars.example` file:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```

5. Modify the `terraform.tfvars` file according to your needs:

6. Customize your `.env` file by copying the `.env.example` file from the `onebusaway-docker` repository and modifying it as needed:
    ```bash
    cp .env.example .env
    ```

7. Deploy the project:
    ```bash
    tofu apply
    ```

8. Opentofu will automatically generate SSH key pairs in the `ssh` folder. You can connect to the server using:
    ```bash
    ssh -i ./ssh/id_rsa <username>@<server_ip>
    ```
   The `server_ip` can be found in the output of the `tofu apply` command.

9. After the deployment is complete, wait a few minutes for the server to start. You can access the OneBusAway server by visiting:
   ```http://<server_ip>:8080```

10. (Optional) If you configured your domain in the `terraform.tfvars` and `.env` file:
    - Add an A record pointing to the server's IP address in your domain provider's DNS settings.
    - For example, if you use Cloudflare, follow the instructions [here](https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare).
    - Caddy will handle the SSL certificate configuration based on this DNS record, allowing you to visit your server securely at `https://<your_domain>`.

## Clean Up

If you need to shut down the server and clean up resources, you can run the following command:
```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the Droplet, network, SSH key pairs, and other related resources.

## Conclusion

This guide has demonstrated how to deploy the OneBusAway server on a DigitalOcean Droplet using Opentofu. If you have any questions or suggestions, feel free to open an issue in the repository.
