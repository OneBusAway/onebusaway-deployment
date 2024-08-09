# Deployment Guide for DigitalOcean App Platform

DigitalOcean App Platform is a platform-as-a-service (PaaS) that makes it easy to build, deploy, and scale apps quickly. This guide will walk you through deploying the OneBusAway server on DigitalOcean App Platform using Opentofu.

> [!WARNING]  
> Currently DigitalOcean App Platform's gVisor is conflicting with supervisor, they already know this issue and will fix it in the future.
> 
> FYI: [App platform supervisor error](https://www.digitalocean.com/community/questions/app-platform-supervisor-error)

## Prerequisites

1. A [DigitalOcean](https://www.digitalocean.com/) account. If you don't have one, you can create an account [here](https://cloud.digitalocean.com/registrations/new).

2. A DigitalOcean API token, which you can generate from the [DigitalOcean Control Panel](https://cloud.digitalocean.com/account/api/tokens).

3. Opentofu, an open-source Terraform alternative. You can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Ensure you have *ALL* the prerequisites installed before starting the deployment.

## Steps

1. Clone this repository to your local machine. You can run:

```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
cd onebusaway-deployment/modules/digitalocean-ap
```

2. Initialize the project. This will download the necessary plugins and providers for the project:

```bash
tofu init
```

3. Create a `terraform.tfvars` file by copying the example variables file, and then modify it according to your needs:

```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edit the `terraform.tfvars` file and update the variable values to match your specific requirements, such as your DigitalOcean API token, region, instance size, environment variables, and more.

5. Run Tofu plan to preview the infrastructure changes:

```bash
tofu plan
```

6. Apply the Tofu configuration to create the actual resources:

```bash
tofu apply
```

Type `yes` when prompted to confirm the resource creation.

7. After the deployment is complete, verify the created resources in the DigitalOcean Control Panel. Ensure the App Platform service, environment variables, and other related resources are created and running correctly.

8. Access the OneBusAway server by visiting the public URL of the App Platform service. You can find the service URL in the DigitalOcean Control Panel under the App Platform service details.

## Clean up

If you want to shut down the server and clean up the resources, you can run the following command:

```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the DigitalOcean App Platform service and associated resources.

## Conclusion

This guide shows you how to deploy the OneBusAway server on DigitalOcean App Platform using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.
