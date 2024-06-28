# Deployment Guide for AWS EC2

AWS EC2 is a good choice for deploying Onebusaway server, it provides a wide range of instance types and sizes, and you can choose the best one for your use case. This guide will show you how to deploy Onebusaway server on AWS EC2.

## Prerequisites

1. An AWS account, if you don't have one, you can create a free account [here](https://aws.amazon.com/free/).

2. AWS CLI, you can install it by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

3. Opentofu, an open-source Terraform alternative, you can install it by following the instructions [here](https://opentofu.org/docs/intro/install/).

4. Make sure you install *ALL* the prerequisites before you start the deployment.
## Steps

1. Clone this repository to your local machine, you can run
```bash
git clone https://github.com/OneBusAway/onebusaway-deployment.git
```

2. Change the directory to `modules/aws-ec2`, you can use command
```bash
cd onebusaway-deployment/modules/aws-ec2
```
3. Configure your AWS credentials using AWS CLI, you can find guide [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html).

4. Initialize the project, this will download the necessary plugins and providers for the project
```bash
tofu init
```

5. Create your custom `.env` file by copying the `.env.example` file, you can find parameters meaning in [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker/)
```bash
cp .env.example .env
```

6. Modify the `.env` and `variables.tf` file according to your needs. You can modify `DOMAIN` to your own domain, this will be used to generate SSL certificate by [Caddy](https://caddyserver.com/). If you want to configure your own certs instead of automatic HTTPS, you can leave `caddy` blank.

7. Deploy the project
```bash
tofu apply
```

8. Tofu will automatically generate ssh key pairs in the `ssh` folder, you can connect to the server using `ssh -i ./ssh/id_rsa <username>@<instance_ip>`.

9. After the deployment is finished, you need to wait a few minutes to let the server start. You can access the Onebusaway server by visiting `http://<instance_ip>:8080`. You can find the instance IP in the AWS Management Console.

10. (optional) If you configured your own domain, you should go to your domain provider and add an A record pointing to the instance IP. For example, if you use Cloudflare, you can follow the instructions [here](https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare). Caddy will configure certs based on the record. You should be able to visit your server by visiting `https://<your_domain>` after a few minutes.

## Clean up
If you want to shut down the server and clean up the resources, you can run the following command
```bash
tofu destroy
```

Opentofu will destroy all resources created by this project, including the EC2 instance, network, ssh key pairs, and other resources.

## Conclusion
This guide shows you how to deploy Onebusaway server on AWS EC2 using Opentofu. If you have any questions or suggestions, feel free to open an issue in this repository.