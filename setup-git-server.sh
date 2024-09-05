sudo rm -rf /var/repo
cd /var
sudo mkdir repo
cd repo
sudo mkdir erp1.kriyapos.com.git
cd erp1.kriyapos.com.git
sudo git init --bare
cd hooks
sudo touch post-receive
sudo chmod +x post-receive
sudo bash -c 'echo "#!/bin/sh" > post-receive'
sudo bash -c 'echo "git --work-tree=/var/www/erp1.kriyapos.com --git-dir=/var/repo/erp1.kriyapos.com.git checkout -f" > post-receive'

echo 'DONE'
cd ..

ssh_port=$(grep -oP "(?<=Port )[0-9]+" sshd_config)
server_ip=$(hostname -I | cut -d' ' -f1)
current_user=$(whoami)
echo "Git created: ssh://$current_user@$server_ip:$ssh_port$(pwd)"