This is the procedure I run to set up k8s cluster on Ubuntu machines

Based on the article
[Simplifying Kubernetes Installation on Ubuntu using a Bash Shell Script](https://medium.com/@olorunfemikawonise_56441/simplifying-kubernetes-installation-on-ubuntu-using-a-bash-shell-script-d75fed68a31)
by Olorunfemi Kawonise

## On master node that will be running the control plane

If there is no unpriveleged user (for example Hetzner creates servers with root SSH), execute as root:

```
sh add_user.sh username_here 'puplic_ssh_key_here'
```

That will create a user, setup SSH login and add the user to sudoers. Now switch to unpriveleged user.

Execute as normal user with sudo priveleges: (It is assumed that the internal network is 10.1.0.0/x):

```
sudo sh common-setup.sh
sudo kubeadm init --pod-network-cidr=10.1.0.0/16 --control-plane-endpoint=$(hostname -I | xargs -n1 | grep ^10.1)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubeadm token create --print-join-command
```
## On worker nodes

```
sudo sh common-setup.sh
```

Then run the command that was printed by `kubeadm token create` on master node (under sudo) to join the cluster

