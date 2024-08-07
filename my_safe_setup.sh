#!/bin/bash

# Function to check and install packages
check_and_install() {
	GR='\033[0;32m'
	RED='\033[0;31m'
	NC='\033[0m' # No Color
    for package in "$@"; do
        if ! dpkg-query -W -f='${Status}' $package 2>/dev/null | grep -q "ok installed"; then
			echo -e "${GR}Installing $package...${NC}"
            sudo apt install -y $package
        else
            echo -e "${RED} $package is already installed. Skipping...${NC}"
        fi
    done
}

# Function to check and create directories
check_and_create_directory() {
	GR='\033[0;32m'
	RED='\033[0;31m'
	NC='\033[0m' # No Color
    for directory in "$@"; do
        if [ ! -d "$directory" ]; then
            echo -e "${GR} Creating directory: $directory ${NC}"
            mkdir -p $directory
        else
			echo -e "${RED}Directory $directory already exists. Skipping... ${NC}"
        fi
    done
}

# update apt
sudo apt update
sudo apt upgrade -y

check_and_install build-essential

# Install additional Apps
check_and_install snapd
# vlc gimp gparted synaptic
# sudo snap install snap-store

# Install Media Codecs
# Note: select yes on all
# check_and_install ubuntu-restricted-extras

# to boost performance and responsiveness with preload
check_and_install preload

# Improve laptop battery
# check_and_install tlp tlp-rdw

# Add numix theme and icons
# sudo add-apt-repository ppa:numix/ppa
# sudo apt-get update
# check_and_install numix-gtk-theme numix-icon-theme-circle

# Add Bleachbit for cleanup
# check_and_install bleachbit

# vs code
# sudo snap install --classic code

# discord
# sudo snap install discord

# spotify
# sudo snap install spotify

# wacom
# sudo add-apt-repository ppa:doctormo/wacom-plus
# sudo apt-get update
# sudo apt-get dist-upgrade
# sudo apt-get install wacom-dkms


# Now for the work-related installations

# git
# check_and_install git

# gcc
sudo apt update

# betty
betty_directory="$HOME/Git_repos/Betty"
if [ ! -d "$betty_directory" ]; then
    check_and_create_directory "$betty_directory"
    cd $betty_directory
    git clone https://github.com/alx-tools/Betty.git
    cd $betty_directory/Betty
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
oh_my_zsh_directory="$HOME/.oh-my-zsh"
if [ ! -d "$oh_my_zsh_directory" ]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed. Skipping..."
fi

# nvim
sudo snap install nvim --classic

# vimplug_config
vimplug_directory="$HOME/.local/share/nvim/site/autoload"
if [ ! -d "$vimplug_directory" ]; then
    check_and_create_directory "$vimplug_directory"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
    echo "VimPlug is already installed. Skipping..."
fi

# pulling our config files
my_ubuntu_directory="$HOME/my_ubuntu"
if [ ! -d "$my_ubuntu_directory" ]; then
    check_and_create_directory "$my_ubuntu_directory"
    git clone git@github.com:mo7amedElfadil/my_ubuntu.git $my_ubuntu_directory
    cd $my_ubuntu_directory
    mv * $HOME/
    nvim -c ':PlugInstall' -c 'qa!'
else
    echo "my_ubuntu config files are already present. Skipping..."
fi

# python
check_and_install python3 python3-pip

# make a requirements file for pip
pip3 install -r $HOME/requirements.txt

# mysql
check_and_install mysql-server
read -p "Start mysql service? (y/n): " start_mysql
if [ $start_mysql = "y" ]; then
	sudo systemctl start mysql.service
fi
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

# virtualenv
sudo apt-get install python3-venv
sudo apt-get install python3-dev
sudo apt-get install libmysqlclient-dev
sudo apt-get install zlib1g-dev
sudo pip3 install mysqlclient
# W3C-Validator
w3c_validator_directory="$HOME/Git_repos/W3C-Validator"
if [ ! -d "$w3c_validator_directory" ]; then
    check_and_create_directory "$w3c_validator_directory"
    cd $HOME/Git_repos
    git clone https://github.com/holbertonschool/W3C-Validator.git
else
    echo "W3C-Validator is already installed. Skipping..."
fi

# Node
sudo apt install nodejs npm

sudo npm install -g eslint
sudo npm install -g pyright


echo ; echo
echo "Remember to manually Download: "
echo "Chrome"
echo
echo "Some programs require further installations:"
echo "mysql"
