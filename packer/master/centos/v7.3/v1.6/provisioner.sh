!#/bin/bash

ARCH=x86_64
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-${ARCH}
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

# base update

yum -y update

# base tools

yum -y install vim htop telnet nginx

# validating some services

if [ $(systemctl -q is-active firewalld) ] ; then
    systemctl stop firewalld
    systemctl disable firewalld
fi

# installing network time protocol

yum -y install ntp
systemctl start ntpd
systemctl enable ntpd

# installing kubernetes 1.6

yum install -y docker kubelet kubeadm kubectl kubernetes-cni

# setting up services

for SERVICES in docker kubelet; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES 
done

# setting up the cluster to start

kubeadm init --apiserver-advertise-address=10.244.0.0/16

sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
echo 'KUBECONFIG=$HOME/admin.conf' >> $HOME/.bashrc

# Adding the addons

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

sleep 10

kubectl create -f https://git.io/kube-dashboard
