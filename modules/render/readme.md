# Deployment Guide for Render

Render is a modern cloud provider that makes it easy to deploy web services, static sites, and databases. This guide will walk you through deploying the OneBusAway server on Render using Opentofu.

## Prerequisites

1. A [Render](https://render.com/) account. If you don't have one, you can create a free account [here](https://dashboard.render.com/register).

2. Opentofu, an open-source Terraform alternative. You can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

3. Ensure you have *ALL* the prerequisites installed before starting the deployment.

## Steps

1. Clone this repository to your local machine. You can run:

```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
cd onebusaway-deployment/modules/render
```

2. Initialize the project. This will download the necessary plugins and providers for the project:

```bash
tofu init
```

3. Create a `terraform.tfvars` file by copying the example variables file, and then modify it according to your needs:

```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edit the `terraform.tfvars` file and update the variable values to match your specific requirements, such as Render API key, service plan, region, container image details, and environment variables.

5. Run Tofu plan to preview the infrastructure changes:

```bash
tofu plan
```

6. Apply the Tofu configuration to create the actual resources:

```bash
tofu apply
```

Type `yes` when prompted to confirm the resource creation.

7. After the deployment is complete, verify the created resources in the Render Dashboard. Ensure the web service, environment variables, and other related resources are created and running correctly.

8. Access the OneBusAway server by visiting the public URL of the Render service. You can find the service URL in the Render Dashboard under the service details.

## Clean up

If you want to shut down the server and clean up the resources, you can run the following command:

```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the Render web service and associated resources.

## Conclusion

This guide shows you how to deploy the OneBusAway server on Render using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.
