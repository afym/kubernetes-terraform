!#/bin/bash

MASTER_IP=$(cat /scripts/master.ip.config)
NODE_IP=$(hostname --ip-address)

# base update

yum -y update

# base tools

yum -y install vim htop telnet

# validating some services

if [ $(systemctl -q is-active firewalld) ] ; then
    systemctl stop firewalld
    systemctl disable firewalld
fi

# installing network time protocol

yum -y install ntp
systemctl start ntpd
systemctl enable ntpd

# installing kubernetes

yum -y install flannel kubernetes

# configurating flannel

cp /etc/sysconfig/flanneld /etc/sysconfig/flanneld.original

cat > /etc/sysconfig/flanneld <<- EOM
FLANNEL_ETCD="http://$MASTER_IP:2379"
FLANNEL_ETCD_PREFIX="/atomic.io/network"
EOM

# configurating kubernetes node

cp /etc/kubernetes/config /etc/kubernetes/config.original

cat > /etc/kubernetes/config <<- EOM
KUBE_LOGTOSTDERR="--logtostderr=true"
KUBE_LOG_LEVEL="--v=0"
KUBE_ALLOW_PRIV="--allow-privileged=false"
KUBE_MASTER="--master=http://$MASTER_IP:8080"
EOM

# configurating kubelet

cp /etc/kubernetes/kubelet /etc/kubernetes/kubelet.original

cat > /etc/kubernetes/kubelet <<- EOM
KUBELET_ADDRESS="--address=0.0.0.0"
KUBELET_PORT="--port=10250"
KUBELET_HOSTNAME="--hostname-override=$NODE_IP"
KUBELET_API_SERVER="--api-servers=http://$MASTER_IP:8080"
KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=registry.access.redhat.com/rhel7/pod-infrastructure:latest"
KUBELET_ARGS=""
EOM

# setting up the services

for SERVICES in kube-proxy kubelet docker flanneld; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES 
done