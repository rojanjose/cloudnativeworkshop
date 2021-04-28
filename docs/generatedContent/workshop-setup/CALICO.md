# Calico

## IBM Cloud Kubernetes Service (IKS)

Calico is installed by default on IKS. To install the `calicoctl` client follow the instructions below.

Connect to your Kubernetes cluster to start using the `calicoctl`. If you need help to setup your free IBM Cloud Kubernetes Service (IKS) cluster, go [here](FREEIKSCLUSTER.md), or to setup your RedHat OpenShift Kubernetes Service (ROKS), go [here](ROKS.md).

## calicoctl

The following commands will install the `calicoctl` client in the browser-based terminal environment at [CognitiveClass.ai](https://labs.cognitiveclass.ai/tools/theiaopenshift/). If you need help setting up the client terminal at CognitiveClass.ai, follow the instructions [here](COGNITIVECLASS.md).

```console
mkdir calico
wget https://github.com/projectcalico/calicoctl/releases/download/v3.17.1/calicoctl -P  ./calico
chmod +x calico/calicoctl
echo "export PATH=$(pwd)/calico/:$PATH" > $HOME/.bash_profile
source $HOME/.bash_profile
calicoctl version

Client Version:    v3.17.1
Git commit:        8871aca3
Unable to retrieve Cluster Version or Type: connection is unauthorized: clusterinformations.crd.projectcalico.org "default" is forbidden: User "system:serviceaccount:sn-labs-remkohdev:remkohdev" cannot get resource "clusterinformations" in API group "crd.projectcalico.org" at the cluster scope
```

## As kubectl Plugin

To install the calicoctl as a plugin to the `kubectl` client, run the following commands,

```console
mkdir calico
curl -o ./calico/kubectl-calico -L  https://github.com/projectcalico/calicoctl/releases/download/v3.17.1/calicoctl
chmod +x ./calico/kubectl-calico
echo "export PATH=$(pwd)/calico/:$PATH" > $HOME/.bash_profile
source $HOME/.bash_profile
kubectl calico -h
```
