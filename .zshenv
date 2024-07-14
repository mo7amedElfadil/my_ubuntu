#!/bin/bash

function help() {
	# prints out the help menu for the custom commands
	echo "Custom commands"
	echo "--------------------------------------------------------------"
	echo "activate_venv: Activate a virtual environment"
	echo "addgit: Add a file to the .gitignore file"
	echo "bot: Run the bot"
	echo "cdd: Change directory to a project directory"
	echo "commit: Add and commit to git"
	echo "connectbnb: Connect to the BnB server"
	echo "connectsandbox: Connect to the sandbox server"
	echo "create_repo: Create a new repository"
	echo "create_venv: Create a new virtual environment"
	echo "deactivate_venv: Deactivate a virtual environment"
	echo "fuzzyfind: Search for a string in files and preview the results using fzf"
	echo "helpcom: Display the help menu"
	echo "hsh: Run the Shell script"
	echo "incr: Increment the prefix of files"
	echo "lazygit: Add, commit and push to git"
	echo "LexDevEnv: Set the Lexilink development environment"
	echo "LexFileEnv: Set the Lexilink file environment"
	echo "LexTestEnv: Set the Lexilink test environment"
	echo "newproj: Create a new project directory"
	echo "newt: Create a new task file"
	echo "pip_installer: Install python modules from a file using pip"
	echo "rog: Set the keyboard light to blue"
	echo "run: Run a task file"
	echo "sqllazy: Lazy SQL commands"
	echo "fuzzyvim: Open nvim to fzf result"
	echo "vv: Open nvim at a specific line number"
}

function fuzzyfind() {
	# search for a string in files and preview the results using fzf
	# the function takes in a string to search for
	query=$1
	grep -rnl "$query" . | fzf --preview "grep --color=always -n '$query' {}"
}

function fuzzyvim() {
    # Open nvim to fzf result. The function takes in a string to search for
	# add option -o to open in neo vim
	# add option -m for multiselect in fzf
	# add option -p to preview the files in fzf
	# add option -h to display the help menu
	# add option -s to search for a string in the files
	
	# Define flags
	nvim_flag=false
	search_flag=false
	
	help_message() {
		echo "Usage: fuzzyvim [-o] [-m] [-p] [-h] [-s <query>]" >&2
		echo "o: open the files in nvim" >&2
		echo "m: allow multiselect in fzf (use tab to select)" >&2
		echo "p: preview the files in fzf" >&2
		echo "s: search for a string in the files using grep before the fzf" >&2
		echo "h: display the help menu" >&2
		return 0
	}

	fzf_command="fzf"
	while getopts ":omps:h" opt; do 
		case ${opt} in
			o)
				nvim_flag=true
				;;
			m)
				fzf_command+=" -m"
				;;
			p)
				fzf_command+=" --preview 'bat --color=always {}'"
				;;
			s)
				search_flag=true
				query=$OPTARG
				;;
			h)
				help_message
				return 0
				;;
            \? )
                echo "Invalid option: -$OPTARG" >&2
                echo "Usage: fuzzyvim [-o] [-m] [-p] [-h] [-s <query>]" >&2
				echo "Use -h for help" >&2
                return 1
                ;;
            : )
                echo "Option -$OPTARG requires an argument." >&2
                echo "Usage: fuzzyvim [-o] [-m] [-p] [-h] [-s <query>]" >&2
				echo "Use -h for help" >&2
                return 1
                ;;
		esac
	done
	shift $((OPTIND -1))


	if [ $search_flag = true ] && [ -z "$query" ]; then
		echo "Option -s requires a query argument." >&2
        echo "Usage: fuzzyvim [-o] [-m] [-p] [-h] [-s <query>]" >&2
		return 1
	fi
	
	echo 'fzf command: ' $fzf_command

	if [ $search_flag = true ]; then
		files=$(grep -rnl "$query" . | eval "$fzf_command")
	else
		files=$(eval "$fzf_command")
	fi
	

	if [ -n "$files" ]; then
		if [ $nvim_flag = true ] ; then
			echo "Opening files..."
			nvim -p $(echo "$files")
		else
			echo "$files"
		fi
	else
		echo "No files selected."
	fi
}


kill_process() {
    # Define color variables
    RED='\033[1;31m'
    YELLOW='\033[1;33m'
    BLUE='\033[1;34m'
    GREEN='\033[1;32m'
    RESET='\033[0m'

    if [ -z "$1" ]; then
        echo -e "${RED}Usage: kill_process <process_name>${RESET}"
        return 1
    fi

    process_name=$1
    processes=$(ps aux | grep -i "$process_name" | grep -v "grep" | grep -v "$0")

    if [ -z "$processes" ]; then
        echo -e "${RED}No processes found matching '$process_name'.${RESET}"
        return 1
    fi

    selected_process=$(echo "$processes" | fzf --header="Select a process to kill" --no-sort --height=20%)

    if [ -z "$selected_process" ]; then
        echo -e "${YELLOW}No process selected.${RESET}"
        return 1
    fi

    pid=$(echo "$selected_process" | awk '{print $2}')
    echo -e "${BLUE}Killing process with PID $pid using SIGTERM...${RESET}"
    kill "$pid"

    # Check if the process is still running and if so, use SIGKILL
    sleep 2
    if ps -p "$pid" > /dev/null; then
        echo -e "${YELLOW}Process $pid did not terminate. Using SIGKILL...${RESET}"
        sudo kill -9 "$pid"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Process $pid killed successfully with SIGKILL.${RESET}"
        else
            echo -e "${RED}Failed to kill process $pid with SIGKILL.${RESET}"
        fi
    else
        echo -e "${GREEN}Process $pid terminated successfully.${RESET}"
    fi
}


# open nvim at specific line number
# Usage: nvimline <line_number> <file>
function vv() {
	nvim +$1 $2
}

# takes a list of files from cmd and incrementes the 
# prefix of the files by 1 and copies them to the
# new file name
# Usage: ./incr.sh 1-file1 2-file2 3-file3
# Output: 2-file1 3-file2 4-file3
incr() {

	# Check if at least one file is provided
	if [ "$#" -lt 1 ]; then
	  echo "Usage: $0 <list of files>"
	  exit 1
	fi

	# Loop through all the arguments (files)
	for file in "$@"; do
	  # Extract the prefix and the filename
	  dirname=$(dirname "$file")
	  filename=$(basename "$file")
	  prefix=$(echo "$filename" | grep -o '^[0-9]*')
	  filename=$(echo "$file" | cut -d'-' -f2-)



	  # Increment the prefix
	  new_prefix=$((prefix + 1))

	  # Construct the new filename with path
	  new_file="${dirname}/${new_prefix}-${filename}"

	  # Copy the file to the new filename
	  cp "$file" "$new_file"

	  echo "Copied $file to $new_file"
	done
}


# Installs python modules using pip
# the script takes in a python file and tries to run it
# if it fails, it will install the required modules until it runs successfully
# if the script runs successfully, it will print the output and exit
# if the script fails, it will print the error message and exit
#
# Usage: ./pip_installer.sh <python_file>
function pip_installer {
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m' # No Color

	# check if the user has provided a python file
	if [ $# -eq 0 ]; then
		echo -e "${RED}Error: No python file provided${NC}"
		exit 1
	fi

	# check if the python file exists
	if [ ! -f $1 ]; then
		echo -e "${RED}Error: File $1 not found${NC}"
		exit 1
	fi

	# check if the python file has a .py extension
	if [[ $1 != *.py ]]; then
		echo -e "${RED}Error: File $1 is not a python file${NC}"
		exit 1
	fi

	# check if the python file is executable
	if [ ! -x $1 ]; then
		echo -e "${RED}Error: File $1 is not executable${NC}"
		exit 1
	fi


	# start by installing requests module
	pip3 install requests


	# check if the python file runs successfully
	if python3 $1; then
		echo -e "${GREEN}Script ran successfully${NC}"
		exit 0
	else
		# get the error message
		error_message=$(python3 $1 2>&1)
		# get the required modules
		while true; do
			# get the required modules
			required_modules=$(echo $error_message | grep -oP "No module named '\K[^']*")
			# check if there are no required modules
			if [ -z "$required_modules" ]; then
				echo -e "${RED}Error: Script failed to run${NC}"
				echo -e "${RED}$error_message${NC}"
				exit 1
			fi
			# install the required modules
			for module in $required_modules; do
				echo -e "${GREEN}Installing $module${NC}"
				pip3 install $module
				# check if the module was installed successfully
				if [ $? -ne 0 ]; then
					# print error message and exit
					echo -e "${RED}Error: Failed to install $module${NC}"
					exit 1
				fi
			done
			# check if the script runs successfully
			if python3 $1; then
				echo -e "${GREEN}Script ran successfully${NC}"
				exit 0
			else
				# get the error message
				error_message=$(python3 $1 2>&1)
			fi
		done
	fi
}

# adds, commits and pushes to git
function lazygit() {
	# check number of arguments
	while getopts ":h" opt; do
		case ${opt} in
			h)
				echo "Usage: lazygit [<file>] <message>"
				return 0
				;;
			\? )
				echo "Invalid option: $OPTARG" 1>&2
				echo "Usage: lazygit [<file>] <message>"
				return 1
				;;
		esac
	done
	if [ $# -eq 1 ]; then
		git add .
		git commit -a -m "$1"
	else
		git add "$1"
		git commit -a -m "$2"
	fi
	git push
}

# adds and commits to git
function commit() {
	git add .
	git commit -m "$1"
}

# creates a precommit file
# the precommit file is used to run gitleaks
# before a commit is made
function create_precommit() {
	echo """
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.16.1
    hooks:
      - id: gitleaks
""" > .pre-commit-config.yaml
	pre-commit autoupdate
	pre-commit install
}


# creates a new github repository remotely and locally
function create_repo() {
	newproj $1
	rm -rf main_files
	git init
	gh repo create $1 --public --source=. --remote=origin
	git branch -m master main
	create_precommit
	lazygit "Initial commit - Creating new repository $1"
	git push --set-upstream origin main
}

# runs the custom shell
function hsh() {
	she
}

# creates a new virtual environment
function create_venv() {
	python3 -m venv $1
}

# sets the keyboard light to blue
function rog() {
	sudo rogauracore initialize_keyboard
	sudo rogauracore single_static 00FFFF
	sudo rogauracore brightness 3
}

# activates a virtual environment given its path
function activate_venv() {
	source $1/bin/activate
}

# deactivates a virtual environment
function deactivate_venv() {
	deactivate
}

# sets the Lexilink development environment
function LexDevEnv() {
	export LEXILINK_MYSQL_USER="lexilink_dev"
	export LEXLEXILINK_MYSQL_PWD="lexilink_dev_pwd"
	export LEXLEXILINK_MYSQL_DB="lexilink_dev_db"
	export LEXLEXILINK_MYSQL_HOST="localhost"
	export LEXLEXILINK_MYSQL_PORT="3306"
	export LEXLEXILINK_TYPE_STORAGE="db"
	export LEXLEXILINK_MYSQL_ENV="dev"
}

# sets the Lexilink test environment
function LexTestEnv() {
	export LEXILINK_MYSQL_USER="lexilink_test"
	export LEXLEXILINK_MYSQL_PWD="lexilink_test_pwd"
	export LEXLEXILINK_MYSQL_DB="lexilink_test_db"
	export LEXLEXILINK_MYSQL_HOST="localhost"
	export LEXLEXILINK_MYSQL_PORT="3306"
	export LEXLEXILINK_TYPE_STORAGE="db"
	export LEXLEXILINK_MYSQL_ENV="test"
}

# sets the Lexilink file environment
function LexFileEnv() {
	export LEXILINK_TYPE_STORAGE="file"
	export LEXILINK_MYSQL_ENV="dev"
}

# changes directory to a project directory
function cdd() {
    root="$HOME/alx_se"
	#check how many arguments are passed
	if [ $# -eq 0 ]; then
		cd "$root"
		return
	fi
	if [ $# -eq 1 ]; then
		cd "$root"/*"$1"*
		return
	fi
	# if more than one argument is passed
	if [ $# -eq 2 ]; then
		cd "$root"/*"$1"*/*"$2"*
		return
	fi
}

# Remotely interacts with the discord bot
function bot()
{
	if [ -z "$1" ]; then
		echo "Usage: bot [r/run/k/kill/t/tail/l/log/s/status/u/update]"
		return 1
	fi
	IP=$SERVER3LB
	USER=ubuntu
	# r or run
	# k or kill
	if [ "$1" = "r" ] || [ "$1" = "run" ]; then
		echo "starting bot"
		ssh -i "$sshKEY" "$USER@$IP" "pkill bot"
		COMMAND="bot $discordTOKEN"
	elif [ "$1" = "k" ] || [ "$1" = "kill" ]; then
		echo "killing bot"
		COMMAND="pkill bot"
	elif [ "$1" = 't' ] || [ "$1" = 'tail' ]; then
		echo "reading tail of bot log"
		COMMAND="tail -f /home/$USER/RMFBot/bot_log/bot_log.txt"
	elif [ "$1" = 'l' ] || [ "$1" = 'log' ]; then
		echo "reading bot log file"
		COMMAND="less /home/$USER/RMFBot/bot_log/bot_log.txt"
	elif [ "$1" = 's' ] || [ "$1" = 'status' ]; then
		echo "checking bot status"
		COMMAND="pgrep bot && echo 'Bot is running' || echo 'Bot is not running'"
	elif [ "$1" = 'u' ] || [ "$1" = 'update' ]; then
		FILE=~/alx_se/RMFbot/bkup/version2/bot
		IP="$SERVER3LB"
		USER="ubuntu"
		path_to_ssh_key="$sshKEY"
		scp -o StrictHostKeyChecking=no -i "$path_to_ssh_key" "$FILE" "$USER@$IP":/bin/
		bot r
		return 0
	else
		echo "Invalid argument"
		echo "Usage: bot [r/run/k/kill/t/tail/l/log/s/status/u/update]"
		return 1
	fi
	ssh -i "$sshKEY" "$USER@$IP" "$COMMAND"
}

# Add a file to the .gitignore file to not ignore it
addgit() {
	echo "!/$1" >> .gitignore
}

# Connect to the sandbox server
connectsandbox() {
	sshpass -p '2b5a5164165bc7fc06dc' ssh 71dd44fbcc5a@71dd44fbcc5a.36545ba6.alx-cod.online

}

# Connect to the BnB server
connectbnb() {
	sshpass -p '9964419af7de2b04f883' ssh 0ab8c02e7ebc@0ab8c02e7ebc.f861a72c.alx-cod.online
}

# Create a new task file with a main file (optional)
# the task file is created with a template
# The file can be ran and tested for code style errors after quitting the editor
newt() {
	auto_flag=false
	commit_flag=false
	file_flag=false
	main_flag=false
	run_flag=false
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m' # No Color
	while getopts ":acfhmr" opt; do
		case ${opt} in
			a )
				auto_flag=true
				;;
			c )
				commit_flag=true
				;;
			m )
				main_flag=true
				;;
			f )
				file_flag=true
				main_flag=true
				;;
			h)
				echo "Usage: newt [-a] [-c] [-f] [-h] [-m] [-r] <file>"
				echo "Options:"
				echo "  -a: Automatically commit the file using its name"
				echo "  -c: Commit the file to git"
				echo "  -f: Main file will be shell script"
				echo "  -h: Display help menu"
				echo "  -m: Create a main file"
				echo "  -r: Run the file"
				return 1
				;;
			r )
				run_flag=true
				;;
			\? )
				echo "Invalid option: $OPTARG" 1>&2
				echo "Usage: newt [-a] [-c] [-f] [-h] [-m] [-r] <file>"
				return 1
				;;
		esac
	done

	shift $((OPTIND -1))


	if [[ $1 == *".c" ]] 
	then 
		echo -e "#include \"main.h\"\n/**\n * main - Entry point\n *\n * Return: Always 0 (Success)\n */\nint main(void)\n{\n\n\n\treturn (0);\n}" >>$1
	elif [[ $1 == *".py" ]] 
	then
		echo -e "#!/usr/bin/env python3" >> $1
		chmod +x $1
	elif [[ $1 == *".js" ]] 
	then
		echo -e "#!/usr/bin/node" >> $1
		chmod +x $1

	else
		echo "#!/usr/bin/env bash" >> $1
		chmod +x $1
	fi
	if [[ "$1" == *.* ]]; then
		extension=$(echo "$1" | rev | cut -d'.' -f1 | rev)
		if [[ $extension == "py" ]]; then
			tester=pycodestyle
		elif [[ $extension == "js" ]]; then
			tester=semistandard
		elif [[ $extension == "sh" ]]; then
			tester=shellcheck
		elif [[ $extension == "c" ]]; then
			tester=betty
		fi
	else
		extension="sh"
	fi

	number=$(echo "$1" | grep -oE '^[0-9]+')
	
	if $main_flag;
	then
		if $file_flag; then
			extension="sh"
		fi
		main_file=main_files/$number-main.$extension
		echo "Main file created: $main_file"
		if [ ! -d "main_files" ]
		then
			mkdir main_files
		fi
		if [[ $main_file == *".py" ]] 
		then
			echo """#!/usr/bin/python3
import os
import sys

# Get the current directory of the script
current_dir = os.path.dirname(os.path.realpath(__file__))

# Get the parent directory by joining the current directory with '..'
parent_dir = os.path.abspath(os.path.join(current_dir, os.pardir))

# Add the parent directory to the system path
sys.path.append(parent_dir)
""" >> $main_file
			chmod +x $1
		elif [[ $main_file == *".js" ]] 
		then
			echo "#!/usr/bin/node" >> $main_file

		else
			if [[ $main_file == *".c" ]] 
			then 
				echo -e "#include \"main.h\"\n/**\n * main - Entry point\n *\n * Return: Always 0 (Success)\n */\nint main(void)\n{\n\n\n\treturn (0);\n}" >> $main_file
			else
				echo "#!/usr/bin/env bash" >> $main_file
			fi
		fi

		chmod +x $main_file
		nvim $main_file
	fi
	nvim $1
	if $run_flag; then
		if $main_flag; then
			./$main_file
		else
			./$1
		fi
	fi
	
	$tester $1
	if $commit_flag; then
		if $auto_flag; then
			lazygit "$1"
		else
			echo "Enter commit message: "
			read message
			lazygit "$1" "$message"
		fi
	fi
}

# Creates a new sql database and imports data from a website (optional)
# the user is prompted to enter the database name, table name 
# and link to the data
# the user can choose to create a new database or import data from a website
# the user is shown the first 10 rows of the table
sqllazy() {
	vared -p 'Enter DB name:        
	>' -c db_name
	vared -p 'Do you want to create a DB? y/n?        
	>' -c response
	if [[ $response == "y" || $response == "Y" ]]
	then
		create_db="CREATE DATABASE IF NOT EXISTS "
		echo "$create_db $db_name;" | mysql -uroot -p
	fi
	response=""
	vared -p 'Do you want to import data from a website? y/n?        
	>' -c response
	if [[ $response == "y" || $response == "Y" ]]
	then
		vared -p 'Please Enter DB link        ' -c db_link
		curl "$db_link" -s | mysql -uroot -p "$db_name"
	fi
	vared -p 'Enter table name:        
	>' -c tb_name
	show_db="SELECT * FROM "
	echo "$show_db $tb_name;" | mysql -uroot -p "$db_name" | head
}


# Run task file
# runs the main file of a task file
# from main_files directory
# the argument is the file number eg 1, 2, 3
# eg. the file name is $1-main.js
run() {

	# Check if an argument is provided
	if [ -z "$1" ]; then
		echo "Please provide the file number as an argument."
		return 1
	fi
	# check if input is a number or a file name
	# if number, continue, if file name, get the number at the beginning of the file name
	# if no number is found, set the number to -1
	if [[ ! "$1" =~ ^[0-9]+$ ]]; then
		number=$(echo "$1" | grep -oE '^[0-9]+')
		if [ -z "$number" ]; then
			number=-1
		fi
	else
		number=$1
		# set -- "$number"
	fi
	if [ $number -eq -1 ]; then
		./$1
		return 0
	fi
	# Construct the command to run the main file
	file=$(ls | grep "$number-" | head -n 1)
	echo "file: $file"
	if [[ "$file" == *.* ]]; then
		extension=$(echo "$file" | rev | cut -d'.' -f1 | rev)
	else
		extension="sh"
	fi


	len=$(echo "$extension" | wc -l)
	if [[ $len -gt 1 ]]; then
		while IFS= read -r ext; do
			if [[ $ext == "py" ]]; then
				extension="py"
			elif [[ $ext == "js" ]]; then
				extension="js"
			elif [[ $ext == "sh" ]]; then
				extension="sh"
			else
				extension="sh"
			fi
		done <<< "$extension"
	fi
	if [[ $extension == "pp" ]]; then
		extension="sh"
	fi
	if [[ -f main_files/$number-main.$extension ]]; then
		command="main_files/$number-main.${extension}"
	elif [[ -f main_files/$number-main.sh ]]; then
		command="main_files/$number-main.sh"
	else
		command="$file"
	fi

	# Check if the file exists before attempting to run it
	if [ ! -f "$command" ]; then
		echo "Error: File $command not found."
		return 1
	fi
	# Run the command with arguments
	if [[ $# -gt 1 ]]; then
		echo "Running ./$command ${@:2}"
		./$command "${@:2}"  2>/dev/null || sudo ./$command "${@:2}" 2>/dev/null
	else
		./$command 
	fi 
}


# function to create a new project directory
# the function takes in the name of the project
# and creates a new directory with the project name
# the function also creates a README.md file and a main_files directory
# the function also creates a .gitignore file with the necessary files
newproj() {
	mkdir $1
	cd $1
	echo "# $1" >> README.md
	mkdir main_files
	echo "What language are you using? (c, py, js, sh)"
	read language
	if [[ $language == "c" ]]
	then
		echo -e "*\n!/*.so\n!/.gitignore\n!/*.h\n!/*.c\n!/*.sh\n!/README.md\n*main.c" >> .gitignore
	elif [[ $language == "py" ]]
	then
		echo -e "*\n!/*.py\n!/.gitignore\n!/README.md\n!/LICENSE\n*main.py" >> .gitignore
	elif [[ $language == "js" ]]
	then
		echo -e "*\n!/*.js\n!/.gitignore\n!/README.md\n!/LICENSE\n*main.js" >> .gitignore
	elif [[ $language == "sh" ]]
	then
		echo -e "*\n!/*.sh\n!/.gitignore\n!/README.md\n!/LICENSE\n*main.sh" >> .gitignore
	else
		echo -e "*\n!/.gitignore\n!/README.md\n!/LICENSE" >> .gitignore
		echo "Make sure to add the file extensions to the .gitignore file"
	fi
}

