#!/bin/bash

# Pastikan jumlah argumen yang diberikan adalah satu
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

project_name="$1"
project_dir="/var/www/html/$project_name"
repo_dir="/var/repo/$project_name.git"

# Konfigurasi identitas pengguna Git
sudo git config --system user.email "dev.kriyanesia@gmail.com"
sudo git config --system user.name "dak_account"

# Periksa apakah direktori proyek sudah ada
if [ ! -d "$project_dir" ]; then
    echo "Project directory '$project_dir' not found."
    exit 1
fi

# Periksa apakah direktori repositori sudah ada
if [ -d "$repo_dir" ]; then
    echo "Project '$project_name' already exists. Deleting existing repository..."
    sudo rm -rf "$repo_dir"
fi

# Buat repositori kosong
sudo mkdir -p "$repo_dir"
sudo git init --bare "$repo_dir"

# Salin konten dari proyek ke repositori
sudo git --git-dir="$repo_dir" --work-tree="$project_dir" add .
sudo git --git-dir="$repo_dir" --work-tree="$project_dir" commit -m "Initial commit"

# Setup post-receive hook untuk melakukan checkout
sudo mkdir -p "$repo_dir/hooks"
sudo touch "$repo_dir/hooks/post-receive"
sudo chmod +x "$repo_dir/hooks/post-receive"
sudo bash -c 'echo "#!/bin/sh" > "$repo_dir/hooks/post-receive"'
sudo bash -c 'echo "git --work-tree=$project_dir --git-dir=$repo_dir checkout -f" >> "$repo_dir/hooks/post-receive"'

echo 'DONE'
repo_path="$repo_dir"
cd /etc/ssh || exit
ssh_port=$(grep -oP "(?<=Port )[0-9]+" sshd_config)
server_ip=$(hostname -I | cut -d' ' -f1)
current_user=$(whoami)
echo "Git created: ssh://$current_user@$server_ip:$ssh_port$repo_path"