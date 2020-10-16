# k3os-vbox-up
Automatically Build A Multi-Nodes K3OS Cluster In **5 Minutes - from 0**
This is mainly for development and test.

# Prerequisites
You should have followings installed:

* bash ( for windows you can use git bash)
* [packer](https://www.packer.io/)
* [vagrant](https://www.vagrantup.com/)
* [virtual box](https://www.virtualbox.org/)

# Quick Start

```bash
cd k3os-vbox-up
./pack.sh
./up.sh
```
That's it! By default you have 3 vm running with k3s: 1 master, 2 nodes: 

```bash
k3s-master [~]$ kubectl get pod --all-namespaces -o wide
NAMESPACE     NAME                                         READY   STATUS      RESTARTS   AGE   IP          NODE         NOMINATED NODE
  READINESS GATES
k3os-system   system-upgrade-controller-66d5c7dd6b-c4dkz   1/1     Running     0          51m   10.42.0.4   k3s-master   <none>
  <none>
kube-system   metrics-server-7566d596c8-prppp              1/1     Running     0          51m   10.42.0.2   k3s-master   <none>
  <none>
kube-system   local-path-provisioner-6d59f47c7-xvh79       1/1     Running     0          51m   10.42.0.3   k3s-master   <none>
  <none>
kube-system   coredns-7944c66d8d-hxb82                     1/1     Running     0          51m   10.42.1.3   k3s-node-1   <none>
  <none>
kube-system   helm-install-traefik-wbrmc                   0/1     Completed   0          51m   10.42.1.2   k3s-node-1   <none>
  <none>
kube-system   svclb-traefik-pfcbk                          2/2     Running     0          50m   10.42.0.5   k3s-master   <none>
  <none>
kube-system   svclb-traefik-6nsz2                          2/2     Running     0          50m   10.42.1.4   k3s-node-1   <none>
  <none>
kube-system   svclb-traefik-wq2z8                          2/2     Running     0          50m   10.42.2.3   k3s-node-2   <none>
  <none>
kube-system   traefik-758cd5fc85-4thxp                     1/1     Running     0          50m   10.42.2.2   k3s-node-2   <none>
  <none>
```

# Customize
Edit `env.sh`, change some env vars.
For example, to increase nodes to 5:

```bash
export NODES_NUM=5        # k3s nodes number
```
Then run:
```bash
./up.sh
```
Just a few minutes then you get:
```bash
k3s-master [~]$ kubectl get node
NAME         STATUS   ROLES    AGE    VERSION
k3s-master   Ready    master   61m    v1.18.9+k3s1
k3s-node-1   Ready    <none>   61m    v1.18.9+k3s1
k3s-node-2   Ready    <none>   61m    v1.18.9+k3s1
k3s-node-3   Ready    <none>   111s   v1.18.9+k3s1
k3s-node-5   Ready    <none>   87s    v1.18.9+k3s1
k3s-node-4   Ready    <none>   12s    v1.18.9+k3s1
```



