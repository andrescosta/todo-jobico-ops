# Getting Started

1. Get Todo-Jobico source code

```bash 
$ git clone https://github.com/andrescosta/todo-jobico-cloud
```

2. Create the Kubernetes cluster

```bash
$ wget https://github.com/andrescosta/jobico-cloud/archive/refs/tags/v2.5.tar.gz
$ tar xzf v2.5.tar.gz 
$ cd jobico-cloud-2.5/
$ ./cluster.sh cfg # This command will generate the cloud-init config files.
...
$ ./cluster new --services # It will create a new K8s cluster with 1 worker node and extras.
```

4. Add Jobico CA locally
```bash
$ cd hacks
$ ./cert_add.sh
```

5. Configure Split DNS

You can follow any online tutorials specific to your Linux distribution for this step. Configure the domain **jobico.local** and the DNS server **192.168.122.23**.

6. Create a **Service User** on Zitadel for the provisioning APIs:

   1. Create the **Service User** using the Zitadel console in https://id.jobico.local/. More info: https://zitadel.com/docs/guides/manage/console/users
   2. Assign the IAM Managers role to the user. More info: https://zitadel.com/docs/guides/manage/console/managers
   3. Create a new KEY here: https://id.jobico.local/ui/console/users/279426608861806877?id=keys and copy the file with the generated KEY to todo-jobico-cloud/_infra/id as **key.json**
  
7. Setup the application

```bash
$ cd todo-jobico-cloud/_infra/bin
$ ./setup.sh # This step create the database and configure the application on Zitadel.
```
8. Configure the Client ID

The output of the previous step is the Cliend ID for our app which must be configured in **todo-web/src/index.js**

9. Deploy the application on Kubernetes

```bash
$ ./deploy.sh # From todo-jobico-cloud/_infra/bin
```
10. Try the App

Open your browser and access to: https://todo.jobico.local

12. Check the Grafana dashboards:

Open your browser and access to: https://grafana.jobico.local/
