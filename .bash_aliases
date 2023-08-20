alias task="cd ~/alx_se/alx-low_level_programming/0x04-more_functions_nested_loops"
alias vi="nvim"
alias vim="nvim"
alias l="ls -la"

function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

export -f lazygit

function newT(){
	echo "Enter file name"

	read f_name
	if [ $(echo $f_name | rev | cut -c 1-2) == 'c.' ] 
	then 
		echo -e "#include \"main.h\"\n/**\n * main - Entry point\n *\n * Return: Always 0 (Success)\n */\nint main(void)\n{\n\n\n\treturn (0);\n}" >>$f_name
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

