# Update host name
sudo nano /etc/hostname

# Install the docker.io package
sudo apt install -y docker.io

# Enable docker to run at boot
sudo systemctl enable docker.service

# Create or replace the contents of /etc/docker/daemon.json to enable the systemd cgroup driver
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Append the cgroups and swap options to the kernel command line
# Note the space before "cgroup_enable=cpuset", to add a space after the last existing item on the line
sudo sed -i '$ s/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1/' /boot/firmware/cmdline.txt

# Enable net.bridge.bridge-nf-call-iptables and -iptables6
sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

# Add the packages.cloud.google.com atp key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the Kubernetes repo
sudo cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update the apt cache and install kubelet, kubeadm, and kubectl
# (Output omitted)
sudo apt update && sudo apt install -y kubelet kubeadm kubectl

# Disable (mark as held) updates for the Kubernetes packages
sudo apt-mark hold kubelet kubeadm kubectl

# Reboot after install
sudo reboot now