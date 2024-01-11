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
	else
		echo "#!/usr/bin/env bash" >> $1
	fi
	nvim $1

	chmod u+x $1

	echo "Begin Commit process? y/n"
	read response
	if [[ $response == "y" ]]
	then
		git add $1
		git commit -m "$1"
		git push
	fi
}
