#!/bin/bash

# Function to check and install packages
check_and_install() {
    for package in "$@"; do
        if ! dpkg -l | grep -q $package; then
            echo "Installing $package..."
            sudo apt install -y $package
        else
            echo "$package is already installed. Skipping..."
        fi
    done
}




# update apt
sudo apt update
sudo apt upgrade -y

# Install additional Apps
check_and_install vlc gimp gparted synaptic snapd
sudo snap install snap-store

# Install Media Codecs
# Note: select yes on all
check_and_install ubuntu-restricted-extras

# to boost performance and responsiveness with preload
check_and_install preload

# Improve laptop battery
check_and_install tlp tlp-rdw

# Add numix theme and icons
sudo add-apt-repository ppa:numix/ppa
sudo apt-get update
check_and_install numix-gtk-theme numix-icon-theme-circle

# Add Bleachbit for cleanup
check_and_install bleachbit

# vs code
sudo snap install --classic code

# discord
sudo snap install discord

# spotify
sudo snap install spotify

# Now for the work-related installations

# git
check_and_install git

# gcc
sudo apt update
check_and_install build-essential

# betty
if [ ! -d "~/Git_repos/Betty" ]; then
    mkdir -p ~/Git_repos
    cd ~/Git_repos
    git clone https://github.com/alx-tools/Betty.git
    cd ~/Git_repos/Betty
    sudo ./install.sh
    echo -e "#!/bin/bash\n
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
else
    echo "Betty is already installed. Skipping..."
fi

# valgrind
check_and_install valgrind

# zsh
check_and_install zsh
if [ ! -d "~/.oh-my-zsh" ]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed. Skipping..."
fi

# nvim
sudo snap install nvim --classic

# vimplug_config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# pulling our config files
cd ~
if [ ! -d "~/my_ubuntu" ]; then
    git clone git@github.com:mo7amedElfadil/my_ubuntu.git
    cd my_ubuntu
    mv * ~/
    nvim -c ':PlugInstall' -c 'qa!'
else
    echo "my_ubuntu config files are already present. Skipping..."
fi

# python
check_and_install python3
# make a requirements file for pip
pip install -r ~/requirements.txt

# mysql
check_and_install mysql-server
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

# W3C-Validator
if [ ! -d "~/Git_repos/W3C-Validator" ]; then
    cd ~/Git_repos
    git clone https://github.com/holbertonschool/W3C-Validator.git
else
    echo "W3C-Validator is already installed. Skipping..."
fi

echo "Remember to manually Download: "
echo "Chrome"

echo ; echo
echo "Some programs require future installations:"
echo "mysql"
