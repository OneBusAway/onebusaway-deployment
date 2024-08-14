# onebusaway-deployment
This repo is using [Opentofu](https://opentofu.org/) and other tools to create cloud deployment strategy for Onebusaway server, it is also part of Google Summer of Code 2024 project.

## Platform Support Status

|                       | VM         | Docker          | K8s          |
|-----------------------|------------|-----------------|--------------|
| Microsoft Azure       | VM ✅       | ACI ✅           | AKS 🚧       |
| Amazon Web Services   | EC2 ✅      | ECS(Fargate) ✅  | EKS 🚧       |
| Google Cloud Platform | GCE ✅      | Cloud Run ✅     | GKE 🚧       |
| Render                | ❌          | DOCKER ✅(See 1) | ❌            |
| DigitalOcean          | Droplets ✅ | AP ⚠️(See 3)    | DOKS 🚧      |
| Native K8s            | ❌          | ❌               | K8S ✅(See 2) |

The following icons are used to represent the status of support for each platform:
- ✅： completed
- ⚠️： partially completed
- 🚧： in progress
- ❌： not applicable
- 🔲： not started

1. Completed by Aaron, you can find Render deployment file here:  [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker), has been integrated into this repo.
2. Completed by Neo2308, you can find `oba.yaml` here: [onebusaway-docker](https://github.com/OneBusAway/onebusaway-docker), has been rewritten in [Helm Charts](https://helm.sh/docs/topics/charts/).
3. DigitalOcean app engine's gVisor is conflicting with supervisor, they already know this issue and will fix it in the future.