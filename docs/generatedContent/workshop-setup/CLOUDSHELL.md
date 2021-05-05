# CLI Environment setup

Most of the labs are run using CLI commands.

The [IBM Cloud Shell](https://shell.cloud.ibm.com) is preconfigured with the full IBM Cloud CLI and tons of plug-ins and tools that you can use to manage apps, resources, and infrastructure.


## 1. Open IBM Cloud Shell

Click on the `IBM Cloud Shell` icon at the top right section of the cloud account page.

![Cluster List](images/cluster/cloud-shell-open.png)


This opens the cloud shell in a new browser tab. 

![CLI Terminal](images/cluster/cloud-shell-terminal.png)


## 2. Setup Helm

The Cloud Shell comes with both Helm 2 and Helm 3 versions. To make sure we use the Helm Version 3 variant, we will create an alias.

* Run the following commands to install Helm Version 3:

```sh
alias helm=helm3
```

* Check the helm version by running the following command:

```sh
helm version --short
```

The result is that you should have Helm Version 3 installed.

```sh
$ helm version --short
v3.2.1+gfe51cd1
```