# Nginx
sudo apt-get install nginx
sudo ufw allow 'Nginx HTTP'
sudo systemctl enable nginx
sudo systemctl start nginx

# php
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2
sudo apt-get install php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring php7.2-mcrypt php7.2-zip php7.2-fpm php7.2-zip php7.2-mysql  
sudo apt-get install php7.2-mbstring
sudo systemctl start php7.2-fpm.service
sudo systemctl enable php7.2-fpm.service
