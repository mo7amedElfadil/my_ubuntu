shopt -s expand_aliases

alias task="cd ~/alx_se/alx-higher_level_programming"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias l="ls -la"
alias gcc_flags="gcc -Wall -Wextra -Werror -pedantic -std=gnu89"
alias rm_swap="rm ~/.local/share/nvim/swap/*"
alias shell="gcc -Wall -Werror -Wextra -pedantic -std=gnu89 *.c -o hsh"
alias she="~/alx_se/simple_shell/./hsh"
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
function hsh() {
	she
}
export -f hsh
export -f lazygit

alx()
{
	# read the the repo name, and project
	read -p "Wt't the repo -> " repo
	read -p "Wt's the project? -> " project

	ALX_PATH="$HOME/alx_se"
	PROJECT="*$repo*"
	# This trick capitalizes the last char
	last="`echo -n $project | tail -c 1 | tr '[:lower:]' '[:upper:]'`"
	# This trick `echo`s the string, except the 1st char
	rest="`echo -n $project | head -c -1`"
	last_cap="$rest$last"
	PROJECT_CAPS="*$repo*/*$last_cap*"

	# test the project exist or not, if so change directory
	# `-n` length of string is non-zero
	if [ -n "$(find "$ALX_PATH" -wholename "$PROJECT/*$project*" -type d)" ]; then
		cd $(echo "$ALX_PATH/$PROJECT/*$project*")
	elif [ -n "$(find "$ALX_PATH" -wholename "$PROJECT_CAPS" -type d)" ]; then 
		cd $(echo "$ALX_PATH/$PROJECT_CAPS")
	else
		echo "$PROJECT is not exist!" | tr -d '*' >&2
	fi
}

function newT(){
	echo "Enter file name"

	read f_name
	if [ $(echo $f_name | rev | cut -c 1-2) == 'c.' ] 
	then 
		echo -e "#include \"main.h\"\n/**\n * main - Entry point\n *\n * Return: Always 0 (Success)\n */\nint main(void)\n{\n\n\n\treturn (0);\n}" >>$f_name
	elif [ $(echo $f_name | rev | cut -c 1-2) == 'yp' ] 
	then
		echo -e "#!/usr/bin/python3" >> $f_name
	else
		echo "#!/bin/bash" >> $f_name
	fi
	vim $f_name

	chmod u+x $f_name

	echo "Begin Commit process? y/n"
	read response
	if [ $response == "y" ]
	then
		git add $f_name
		git commit -m $f_name
		git push
	fi
}

# exec zsh
