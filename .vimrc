:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
" set spell
" set spelllang=en_us
" z= to see suggestions
" set clipboard=unnamed
" Map Ctrl+C to copy to clipboard
vnoremap <C-c> "+y

" Map Ctrl+V to paste from clipboard
nnoremap <C-v> "+p
setlocal keywordprg=pydoc3.10
autocmd BufWritePre *.c :%s/\s\+$//e 
autocmd BufWritePre *.py :%s/\s\+$//e 
autocmd BufWritePre *.html :%s/\s\+$//e 
autocmd BufWritePre *.js :%s/\s\+$//e 
autocmd BufWritePre *.css :%s/\s\+$//e 
autocmd BufWritePre *.sql :%s/\s\+$//e 

augroup custom_indentation
	autocmd!
	" Update indentation for html and css
	autocmd Filetype html,css setlocal ts=2 sw=2 expandtab
	" Update indentation for puppet
	autocmd Filetype puppet setlocal ts=2 sw=2 expandtab
	" Update indentation for js, jsx, tsx
	autocmd Filetype javascript,javascriptreact,typescriptreact,typescript setlocal ts=2 sw=2 expandtab
	" for js/coffee/jade files, 4 spaces
augroup END

" toggle folding
:set foldmethod=indent
" use space to toggle folding
inoremap <F9> <C-O>za
nnoremap <space> za
onoremap <space> <C-C>za
vnoremap <space> zf
" key binding for flodmethod=indent
"nnoremap <leader>fm :set foldmethod=indent<CR>

set background=dark

highlight Normal ctermfg=grey ctermbg=black guifg=grey guibg=black

" :colorscheme iceberg
" :colorscheme jellybeans
" :colorscheme nord
" :colorscheme hybrid
"

" colorscheme scheakur
" ['alduin',
    " \ 'monochrome',  'lucius',  
	" \ 'gruvbox', 'jellybeans',
" colorscheme jellybeans
" :colorscheme gruvbox
" set background=dark
" let g:alduin_Shout_Dragon_Aspect = 1 " almost black background
" let g:alduin_Shout_Become_Ethereal = 1 " black background
" let g:alduin_Shout_Fire_Breath = 1 " adds deep red for special highlight
" let g:alduin_Shout_Aura_Whisper = 1 " Removes Block Matchparens setting and adds an underline
" :colorscheme alduin

" colorscheme tokyonight
" random colors
colorscheme tokyonight-night
" colorscheme tokyonight-storm
" colorscheme tokyonight-day
" colorscheme tokyonight-moon


set smartindent
" set cindent
syntax enable
"set relativenumber
set encoding=UTF-8
"set clipboard+=unnamedplus
set ignorecase
" change line ending in dos
set ff=unix



" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" set leader key to space
let mapleader = ","


" toggle buffers
nnoremap <leader>bb :b#<CR>

" Mapping file explorer key bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:webdevicons_enable_nerdtree = 1
nmap <F8> :TagbarToggle<CR>

" No highlight bindings
nnoremap <silent> <Leader><Space> :noh<CR>

" Exit NERDTree if it's the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Powerline symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
let g:airline_theme='hybrid'

" For automatic formatting on save `.js` using eslint
autocmd bufwritepost *.js,*.tsx,*.jsx silent !eslint % --fix
autocmd bufwritepost *.py silent !pyright % --fix
"autocmd bufwritepost *.html silent !prettier --write %
"autocmd bufwritepost *.css silent !prettier --write %
"autocmd bufwritepost *.scss silent !prettier --write %
"autocmd bufwritepost *.sql silent !sqlformat % --reindent
"autocmd bufwritepost *.c silent !clang-format -i %
"autocmd bufwritepost *.h silent !clang-format -i %
" autocmd bufwritepost *.js silent !semistandard % --fix
" set autoread
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" reduce width of colorcolumn

set colorcolumn=80

" highlight text beyond 80 characters
"highlight ColorColumn ctermbg=0 guibg=lightgrey 
hi ColorColumn term=reverse cterm=bold ctermfg=0 ctermbg=0 gui=bold guifg=red 
"
call matchadd('ColorColumn', '\%81v.\s*\zs\S', 100)

let $BASH_ENV="~/vim_bash"
