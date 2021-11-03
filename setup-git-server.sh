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
echo "Git created: ssh://ip:port$(pwd)"
