# Deployment Guide for Azure Container Instances

Azure Container Instances (ACI) is an excellent choice for deploying the OneBusAway server, providing a fast and straightforward way to run containers in Azure without managing virtual machines. This guide will walk you through deploying the OneBusAway server on Azure Container Instances using Opentofu.

## Prerequisites

1. An Azure account. If you don't have one, you can create a free account [here](https://azure.microsoft.com/en-us/free/).

2. Azure CLI. You can install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

3. Opentofu, an open-source Terraform alternative. You can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Ensure you have *ALL* the prerequisites installed before starting the deployment.

## Steps

1. Clone this repository to your local machine. You can run:

```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
cd onebusaway-deployment/modules/azure-aci
```

2. Initialize the project. This will download the necessary plugins and providers for the project:

```bash
tofu init
```

3. Create a `terraform.tfvars` file by copying the example variables file, and then modify it according to your needs:

```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edit the `terraform.tfvars` file and update the variable values to match your specific requirements, such as Azure region, resource group name, container details, and environment variables. 


5. Run Tofu plan to preview the infrastructure changes:

```bash
tofu plan
```

6. Apply the Tofu configuration to create the actual resources:

```bash
tofu apply
```

Type `yes` when prompted to confirm the resource creation.

7. After the deployment is complete, verify the created resources in the Azure Portal. Ensure the container group, storage account, file share, and other related resources are created and running correctly.

8. Access the OneBusAway server by visiting the public IP of the container instance. You can find the server IP in the Azure Portal under the container group details.

## Clean up

If you want to shut down the server and clean up the resources, you can run the following command:

```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the container group, storage account, file share, and other resources.

## Conclusion

This guide shows you how to deploy the OneBusAway server on Azure Container Instances using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.