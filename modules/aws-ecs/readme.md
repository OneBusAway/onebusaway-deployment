# Deployment Guide for AWS ECS(Fargate)

AWS ECS is a robust choice for deploying the OneBusAway server, providing a managed container orchestration service that simplifies running and scaling containerized applications. This guide will walk you through deploying the OneBusAway server on AWS ECS using Opentofu.

## Prerequisites

1. An AWS account. If you don't have one, you can create a free account [here](https://aws.amazon.com/free/).

2. AWS CLI. You can install it by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

3. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Ensure you have *ALL* the prerequisites installed before starting the deployment.

## Steps

1. Clone this repository to your local machine. You can run:

```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
cd onebusaway-deployment/modules/aws-ecs
```

2. Initialize the project. This will download the necessary plugins and providers for the project:

```bash
tofu init
```

3. Create a `terraform.tfvars` file by copying the example variables file, and then modify it according to your needs:

```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edit the `terraform.tfvars` file and update the variable values to match your specific requirements, such as AWS region, cluster name, container details, and environment variables.

5. Run Tofu plan to preview the infrastructure changes:

```bash
tofu plan
```

6. Apply the Tofu configuration to create the actual resources:

```bash
tofu apply
```

Type `yes` when prompted to confirm the resource creation.

7. After the deployment is complete, verify the created resources in the AWS Management Console. Ensure the ECS cluster, tasks, service, and other related resources are created and running correctly.

8. Access the OneBusAway server by visiting the public IP of the ECS service. You can find the server IP in the AWS Management Console under the ECS service details.

## Clean up

If you want to shut down the server and clean up the resources, you can run the following command:

```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the ECS cluster, task definition, security groups, and other resources.

## Conclusion

This guide shows you how to deploy the OneBusAway server on AWS ECS using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.