### KUbernetes v1.6.4 Cluster using kubeadm over aws

We have a default 4 ec2 instances for this cluster over the default vpc in aws regions.

#### 1. Installing ansible in the local machine
```
$ sudo apt-get install python-pip
$ sudo pip install ansible
```

#### 2. Provision servers

* rename hosts.dist to hosts
* replace x.x.x.x for the public ip v4

```
$ cd ansible/
$ ansible-playbook -i hosts playbook.yml
```

#### 3. Setting up the master

```
$ sudo kubeadm init --apiserver-advertise-address 172.31.32.100
```

#### 4. Setting up the network strategy
```
$ sudo cp /etc/kubernetes/admin.conf $HOME/
$ sudo chown $(id -u):$(id -g) $HOME/admin.conf
$ export KUBECONFIG=$HOME/admin.conf
# https://kubernetes.io/docs/concepts/cluster-administration/addons/
# https://www.weave.works/docs/net/latest/kube-addon/
$ kubectl apply -f https://git.io/weave-kube-1.6
$ kubectl --kubeconfig ./admin.conf get nodes
```

#### 5. Setting up the nodes

```
$ kubeadm join --token <sometoken> 172.31.32.100:6443
```

#### 6. Adding some stuff
```
$ kubectl create -f https://git.io/kube-dashboard
```