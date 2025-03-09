#To resze the Server:
lsblk
sudo growpart /dev/xvda 4
sudo lvextend -l +50%FREE /dev/RootVG/rootVol;sudo lvextend -l +50%FREE /dev/RootVG/varVol;
sudo xfs_growfs / ;sudo xfs_growfs /var;

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl restart docker
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user

#kubectl installation
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

#eksctl
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin