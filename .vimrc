:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
autocmd BufWritePre *.c :%s/\s\+$//e 
autocmd BufWritePre *.py :%s/\s\+$//e 

let $BASH_ENV="~/vim_bash"

