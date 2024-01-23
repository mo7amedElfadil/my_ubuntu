#!/bin/bash



# This is a setup file for my ubuntu in case it crashes t(-_-t')
# update apt
sudo apt update; sudo apt upgrade

# Install additional Apps
sudo apt install vlc gimp gparted synaptic snapd
sudo snap install snap-store

# Install Media Codecs
# Note select yes on all
sudo apt install ubuntu-restricted-extras

# to boost performance and responsiveness with preload
sudo apt install preload

# Improve laptop battery
sudo apt install tlp tlp-rdw

# Add numix theme and icons
sudo add-apt-repository ppa:numix/ppa
sudo apt-get update
sudo apt-get install numix-gtk-theme numix-icon-theme-circle

# Add Bleachbit for cleanup
sudo apt install bleachbit

# vs code
sudo snap install --classic code


# discord
sudo snap install discord

# spotify
sudo snap install spotify


# Now for the work related installations

# git
sudo apt install git
# consider auto registering user and email and generating ssh to quickly setup git account

#
# gcc
sudo apt update
sudo apt install build-essential
# betty
mkdir ~/Git_repos
cd ~/Git_repos
git clone https://github.com/alx-tools/Betty.git
cd ~/Git_repos/Betty
sudo ./install.sh
echo -e "#\!/bin/bash\n
BIN_PATH=\"/usr/local/bin\"\n
BETTY_STYLE=\"betty-style\"\n
BETTY_DOC=\"betty-doc\"\n
if [ \"\$#\" = \"0\" ]; then\n
    echo \"No arguments passed.\"\n
    exit 1\n
fi\n

for argument in \"\$@\" ; do\n
    echo -e \"\\\n========== \$argument ==========\"\n
    \${BIN_PATH}/\${BETTY_STYLE} \"\$argument\"\n
    \${BIN_PATH}/\${BETTY_DOC} \"\$argument\"\n
done" > betty
chmod a+x betty
sudo mv betty /bin/

# valgrind
sudo apt-get install valgrind


# zsh
sudo apt install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# nvim
sudo snap install nvim --classic
# vimplug_config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# pulling our config files
cd ~
git clone git@github.com:mo7amedElfadil/my_ubuntu.git
cd my_ubuntu
mv * ~/
nvim -c ':PlugInstall' \
	-c 'qa!'

# python
sudo apt install python3
## # pycodestyle
# python libs
# make a requirements file for pip
cd ~
pip install -r requirements.txt
#
# mysql
sudo apt install mysql-server
sudo systemctl start mysql.service
# further manual setup required. check the following
# sudo mysql_secure_installation
# mysql -u root -p
# > ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
# > CREATE USER 'username'@'host' IDENTIFIED WITH authentication_plugin BY 'password';
# or
# > CREATE USER 'sammy'@'localhost' IDENTIFIED BY 'password';
# > GRANT PRIVILEGE ON database.table TO 'username'@'host';
# > GRANT CREATE, ALTER, DROP, INSERT, UPDATE, INDEX, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'sammy'@'localhost' WITH GRANT OPTION;
# > FLUSH PRIVILEGES;
# > exit
# mysql -u sammy -p
#
# systemctl status mysql.service
# refer to following for instructions:
# https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-22-04
#

# w3c-Validator
cd ~/Git_repos
git clone https://github.com/holbertonschool/W3C-Validator.git
#

# For chrome we have to use the Browser to Download

echo "Remember to manually Download: "
echo "Chrome"

echo ; echo
echo "Some programs require furture installations:"
echo "mysql"
