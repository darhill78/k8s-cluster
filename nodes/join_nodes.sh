# Your Kubernetes control-plane has initialized successfully!
# To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
# https://kubernetes.io/docs/concepts/cluster-administration/addons/

# Then you can join any number of worker nodes by running the following on each as root:
sudo kubeadm join 10.0.100.53:6443 --token m5wp79.60shun951r9ru8ti --discovery-token-ca-cert-hash sha256:101e2346a6c4861cefb31152b0e3ec5d3d734032fd666d9b21185d7651d239e0

# Reset Kubelet
sudo kubeadm reset
