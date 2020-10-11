# Generate a bootstrap token to authenticate nodes joining the cluster
TOKEN=$(sudo kubeadm token generate)
echo $TOKEN

# Initialize the Control Plane
# (output omitted)
sudo kubeadm init --token=${TOKEN} --kubernetes-version=v1.18.2 --pod-network-cidr=10.244.0.0/16