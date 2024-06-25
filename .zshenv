#!/bin/bash
function lazygit() {
	git add .
	git commit -a -m "$1"
	git push
}

function commit() {
	git add .
	git commit -m "$1"
}

function create_repo() {
	newproj $1
	rm -rf main_files
	git init
	gh repo create $1 --public --source=. --remote=origin
	git branch -m master main
	lazygit "Initial commit"
}

function hsh() {
	she
}

function create_venv() {
	python3 -m venv $1
}

function rog() {
	sudo rogauracore initialize_keyboard
	sudo rogauracore single_static 00FFFF
	sudo rogauracore brightness 3
}

function activate_venv() {
	source $1/bin/activate
}

function deactivate_venv() {
	deactivate
}

function LexDevEnv() {
	export LEXILINK_MYSQL_USER="lexilink_dev"
	export LEXLEXILINK_MYSQL_PWD="lexilink_dev_pwd"
	export LEXLEXILINK_MYSQL_DB="lexilink_dev_db"
	export LEXLEXILINK_MYSQL_HOST="localhost"
	export LEXLEXILINK_MYSQL_PORT="3306"
	export LEXLEXILINK_TYPE_STORAGE="db"
	export LEXLEXILINK_MYSQL_ENV="dev"
}

function LexTestEnv() {
	export LEXILINK_MYSQL_USER="lexilink_test"
	export LEXLEXILINK_MYSQL_PWD="lexilink_test_pwd"
	export LEXLEXILINK_MYSQL_DB="lexilink_test_db"
	export LEXLEXILINK_MYSQL_HOST="localhost"
	export LEXLEXILINK_MYSQL_PORT="3306"
	export LEXLEXILINK_TYPE_STORAGE="db"
	export LEXLEXILINK_MYSQL_ENV="test"
}

function LexFileEnv() {
	export LEXILINK_TYPE_STORAGE="file"
	export LEXILINK_MYSQL_ENV="dev"
}

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


addgit() {
	echo "!/$1" >> .gitignore
}
connectsandbox() {
	sshpass -p '2b5a5164165bc7fc06dc' ssh 71dd44fbcc5a@71dd44fbcc5a.36545ba6.alx-cod.online

}


connectbnb() {
	sshpass -p '9964419af7de2b04f883' ssh 0ab8c02e7ebc@0ab8c02e7ebc.f861a72c.alx-cod.online
}

newt() {
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
	echo "Main file? y/n/f"
	read response
	if [[ $response == "f" ]]
	then
		extension="sh"
		response="y"
	fi
	if [[ $response == "y" ]]
	then
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
	echo "run file? y/n"
	read response
	if [[ $response == "y" ]]
	then
		run $(echo "$1" | grep -oE '^[0-9]+') "${@:2}"
	fi
	$tester $1
	echo "Begin Commit process? y/n"
	read response
	if [[ $response == "y" ]]
	then
		git add $1
		git commit -m "$1"
		git push
	fi
}

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

run() {
	# Run task file
	# runs the main file of a task file
	# from main_files directory
	# the argument is the file number eg 1, 2, 3
	# eg. the file name is $1-main.js

# Check if an argument is provided
if [ -z "$1" ]; then
	echo "Please provide the file number as an argument."
	return 1
fi
# check if input is a number or a file name
# if number, continue, if file name, get the number at the beginning of the file name
if [[ ! "$1" =~ ^[0-9]+$ ]]; then
	number=$(echo "$1" | grep -oE '^[0-9]+')
	if [ -z "$number" ]; then
		echo "Error: Invalid file number."
		return 1
	fi
	# set -- "$number"
else
	number=$1
fi
echo "number: $number"
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

