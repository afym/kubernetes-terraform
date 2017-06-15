Using kubeadm init to install the master We have the following output:


[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"
[apiclient] Created API client, waiting for the control plane to become ready
[apiclient] All control plane components are healthy after 33.511859 seconds
[apiclient] Waiting for at least one node to register
[apiclient] First node has registered after 3.651680 seconds
[token] Using token: 36016a.25b584d6a8a47d33
[apiconfig] Created RBAC rules
[addons] Created essential addon: kube-proxy
[addons] Created essential addon: kube-dns

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run (as a regular user):

  sudo cp /etc/kubernetes/admin.conf $HOME/
  sudo chown $(id -u):$(id -g) $HOME/admin.conf
  export KUBECONFIG=$HOME/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  http://kubernetes.io/docs/admin/addons/

You can now join any number of machines by running the following on each nod
e
as root:

  kubeadm join --token 36016a.25b584d6a8a47d33 172.31.32.100:6443


For ubuntu the kubelet service is located on :

* /etc/systemd/system/kubelet.service.d
* 10-kubeadm.conf