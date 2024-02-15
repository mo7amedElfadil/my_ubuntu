#!/bin/bash
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
function hsh() {
	she
}


newt() {
	if [[ $1 == *".c" ]] 
	then 
		echo -e "#include \"main.h\"\n/**\n * main - Entry point\n *\n * Return: Always 0 (Success)\n */\nint main(void)\n{\n\n\n\treturn (0);\n}" >>$1
	elif [[ $1 == *".py" ]] 
	then
		echo -e "#!/usr/bin/python3" >> $1
		chmod +x $1
	elif [[ $1 == *".js" ]] 
	then
		echo -e "#!/usr/bin/node" >> $1
		chmod +x $1

	else
		echo "#!/usr/bin/env bash" >> $1
		chmod +x $1
	fi
	extension=$(echo "$1" | rev | cut -d'.' -f1 | rev)
	number=$(echo "$1" | grep -oE '^[0-9]+')
	main_file=main_files/$number-main.$extension
	if [ ! -d "main_files" ]
	then
		mkdir main_files
	fi
	nvim $main_file
	chmod +x $main_file
	nvim $1
	echo "run file? y/n"
	read response
	if [[ $response == "y" ]]
	then
		run $(echo "$1" | grep -oE '^[0-9]+')
	fi

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
  exit 1
fi
# check if input is a number or a file name
# if number, continue, if file name, get the number at the beginning of the file name
if [[ ! "$1" =~ ^[0-9]+$ ]]; then
  number=$(echo "$1" | grep -oE '^[0-9]+')
  if [ -z "$number" ]; then
	echo "Error: Invalid file number."
	exit 1
  fi
  # set -- "$number"
else
	number=$1
fi


# Construct the command to run the main file
file=$(ls | grep "$number-.*")
echo $file
extension=$(echo "$file" | rev | cut -d'.' -f1 | rev)
command="main_files/${number}-main.${extension}"

# Check if the file exists before attempting to run it
if [ ! -f "$command" ]; then
  echo "Error: File $command not found."
  exit 1
fi

# Run the command
./$command
}
