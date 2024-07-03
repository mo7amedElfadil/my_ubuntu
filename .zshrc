alias v="nvim"
alias cdhigh="cd ~/alx_se/alx-higher_level_programming"
alias cdlow="cd ~/alx_se/alx-low_level_programming"
alias cdmon="cd ~/alx_se/monty"
alias cddev="cd ~/alx_se/alx-system_engineering-devops"
alias cdsort="cd ~/alx_se/sorting_algorithms"
alias cdbnb33="cd ~/alx_se/AirBnB_clone_v3"
alias cdbnb2="cd ~/alx_se/myAirBnb_v2/AirBnB_clone_v2_v3"
alias cdbnb2="cd ~/alx_se/myAirBnb_v2/AirBnB_clone_v2"
alias cdbnbSQL="cd ~/alx_se/AirBnB_clone_v2"
alias cdtree="cd ~/alx_se/binary_trees"
alias cdgit="cd ~/Git_repos"
alias cdproj="cd ~/alx_se"
alias cdprint="cd ~/alx_se/printf"
alias cdpractice="cd ~/Documents/Random"
alias cdcheck="cd ~/alx_se/checker_suite"
alias cdcheck="cd ~/alx_se/checker_suite"
alias l="ls -la"
alias gcc_flags="gcc -Wall -Wextra -Werror -pedantic -std=gnu89"
alias rm_swap="rm ~/.local/share/nvim/swap/*"
alias shell="gcc -Wall -Werror -Wextra -pedantic -std=gnu89 *.c -o hsh"
alias she="~/alx_se/simple_shell/./hsh"
alias monty="gcc -Wall -Werror -Wextra -pedantic -std=c89 *.c -o monty"
alias venv="python3 -m venv venv"
alias act="source venv/bin/activate"
alias deact="deactivate"
alias venv="python3 -m venv venv"
alias act="source venv/bin/activate"
alias deact="deactivate"
alias suroot='sudo -E -s'
alias w3c_validator="python3 ~/Git_repos/W3C-Validator/w3c_validator.py"
alias settings="gnome-control-center"
alias update="sudo apt update && sudo apt upgrade"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias zshtheme="nvim ~/.oh-my-zsh/custom/themes/example.zsh-theme"
alias mysql="sudo mysql"
alias mysql_root="sudo mysql -u root -p"
alias run_dd="DD_SITE=$DD_SITE DD_API_KEY=$DD_API_KEY DD_APP_KEY=$DD_APP_KEY python3 $1"
alias run_dd="DD_SITE=$DD_SITE DD_API_KEY=$DD_API_KEY DD_APP_KEY=$DD_APP_KEY python3 $1"
##########################################################################

export RESET='\e[0m' # No Color
export COLOR_RED='\e[0;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_RED='\e[0;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'
# export SERVER1=54.144.238.161
export SERVER1=18.234.145.137
# export SERVER2=100.25.154.52
export SERVER2=54.196.49.246
# export SERVER3LB=52.3.249.43
export SERVER3LB=54.209.103.106
# export SERVER1=54.144.238.161
export SERVER1=18.234.145.137
# export SERVER2=100.25.154.52
export SERVER2=54.196.49.246
# export SERVER3LB=52.3.249.43
export SERVER3LB=54.209.103.106
export pynetsandboxUSER='9c93421f0a2b'
export pynetsandboxHOST='9c93421f0a2b.14cd97b2.alx-cod.online'
export pynetsandboxPW='790491d291413e324e5d'
export sshKEY='~/.ssh/id_rsa'
source ~/.zshvars
# If you come from bash you might have to change your $PATH.
 # export PATH=$HOME/bin:/usr/local/bin:$PATH
alias connectweb1="ssh -i ~/.ssh/id_rsa ubuntu@$SERVER1"
alias connectweb2="ssh -i ~/.ssh/id_rsa ubuntu@$SERVER2"
alias connectlb="ssh -i ~/.ssh/id_rsa ubuntu@$SERVER3LB"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/bin"
export NODE_PATH=/usr/lib/node_modules
export NODE_PATH=/usr/lib/node_modules
# export PATH=$PATH:$(npm bin -g)
export DD_SITE="datadoghq.com"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="gnzh"
# ZSH_THEME="smt"
ZSH_THEME="example"
# ZSH_THEME="random"
prompt_context(){}
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
 zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python)
ZSH_DISABLE_COMPFIX='true'
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Look up ALX project
alx() {
    # read the repo name, and project
    read "repo?What's the repo? -> "
    read "project?What's the project? -> "

    ALX_PATH="$HOME/alx_se"
    PROJECT="*$repo*"
    # last="`echo -n $project | tail -c 1 | tr '[:lower:]' '[:upper:]'`"
    # rest="`echo -n $project | head -c -1`"
    # last_cap="$rest$last"
    # PROJECT_CAPS="*$repo*/*$last_cap*"

    # test if the project exists or not; if so, change directory
    # `-n` length of string is non-zero
    if [ -n "$(find "$ALX_PATH" -wholename "$PROJECT" -type d)" ]; then
        cd "$(echo "$ALX_PATH/$PROJECT")"
    # elif [ -n "$(find "$ALX_PATH" -wholename "$PROJECT_CAPS" -type d)" ]; then
    #     cd "$(echo "$ALX_PATH/$PROJECT_CAPS")"
    else
        echo "$PROJECT is not exist!" | tr -d '*' >&2
    fi
}


# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias zshenv="nvim ~/.zshenv"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vimconfig="nvim ~/.config/nvim/init.lua"
alias vimrc="nvim ~/.vimrc"
# export LD_PRELOAD="/home/mo7amed/git/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:/snap/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
neofetch
