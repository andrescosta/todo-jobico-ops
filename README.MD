# Introduction

This repository showcases the results of my experiments with various GitOps and CI/CD tools, using a simple React TODO application with a Java backend implemented in Spring Boot. Detailed information about its architecture can be found in the accompanying document: [ARCH.md](ARCH.md).

# Stacks

## Application 
- **Frontend**:  React
- **Backend**: Java 21 and Spring Boot
- **Authentication & Authorization**: Zitadel (provided by Jobico)
- **Database**: PostgreSQL (provided by Jobico)

## CI/CD

- [Buildah](https://buildah.io/)
- [Helm](https://helm.sh/)
- [ArgoCD](https://argoproj.github.io/cd/)
- [Tekton](https://tekton.dev/)

# Experiments

This section covers various proofs of concept, ranging from simple local deployments using Helm to more complex scenarios involving ArgoCD or Tekton.

![](img/assesments.png)

## GitOps

### POMCI

This solution employs Helm for manifest templating, ArgoCD for deploying to Kubernetes, GitHub as the charts repository, and POMCI (a custom shell script) for monitoring changes, building container images with Buildah, and pushing them to the registry. The POMCI script can be found at this location: [_infra/argocd/pomci/build.sh](_infra/argocd/pomci/build.sh) and the charts in this repository: [todo-charts](https://github.com/andrescosta/todo-charts). 
 
#### Workflow

![](img/pomci.png)

### Tekton

This solution is implemented as a Tekton pipeline triggered by a Kubernetes cron job. The pipeline compares the last commit hash of the repository with the one for the current deployment; if they differ, it initiates a build and deployment process using Buildah and Helm.

You can find the pipeline at the following location: [_infra/tektoncd/pipeline/pipeline.yaml](_infra/tektoncd/pipeline/pipeline.yaml)

#### Workflow

![](img/tekton.png)

## Local Deployment

This part outlines two alternatives using a local repository and Helm upgrade/install commands.

### Charts

This script deploys the charts found in this repository: [todo-charts](https://github.com/andrescosta/todo-charts).Each time it is called, the application will be deployed with a version based on the current epoch time.

```bash
$ cd _infra/helm/local
$ ./install.sh
$ helm list
```
### OCI

In this use case, the charts are stored in the cluster container registry and referenced during application deployment.

```bash
$ cd _infra/helm/oci/
$ ./pkg.sh # It pushes the charts to the container registry.
$ ./install.sh # It deploys the service and web app using the charts in the registry
$ helm list
```

Once the charts are uploaded to the registry, `install.sh` can be run at any time to deploy a new version of the application.