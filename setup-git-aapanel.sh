sudo rm -rf /var/repo
cd /var
sudo mkdir repo
cd repo
sudo mkdir academy.perbarindo.org.git
cd academy.perbarindo.org.git
sudo git init --bare
cd hooks
sudo touch post-receive
sudo chmod +x post-receive
sudo bash -c 'echo "#!/bin/sh" > post-receive'
sudo bash -c 'echo "git --work-tree=/www/wwwroot/academy.perbarindo.org --git-dir=/var/repo/academy.perbarindo.org.git checkout -f" > post-receive'

echo 'DONE'
cd ..
echo "Git created: ssh://ip:port$(pwd)"
