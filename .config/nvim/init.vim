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

	" for html/rb files, 2 spaces
	autocmd Filetype html setlocal ts=2 sw=2 expandtab
	" for js/coffee/jade files, 4 spaces
	autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
augroup END

" toggle folding
:set foldmethod=indent
" use space to toggle folding
inoremap <F9> <C-O>za
nnoremap <space> za
onoremap <space> <C-C>za
vnoremap <space> zf

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'junegunn/goyo.vim'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'junegunn/vim-github-dashboard'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'ThePrimeagen/vim-be-good'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'


Plug 'nanotee/sqls.nvim'

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'https://github.com/wolandark/vim-live-server.git'
" If you have nodejs and yarn
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
"
Plug 'dense-analysis/ale'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors

Plug 'folke/tokyonight.nvim'
" Plug 'https://github.com/kentchiu/gemini.nvim' " Gemini 


set encoding=UTF-8

call plug#end()
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
:let mapleader = ","
let g:ale_echo_msg_format = '%linter% says %s'
" Disable ALE by default
let g:ale_enabled = 1
" Enable ALE for specific filetypes if needed
autocmd FileType javascript let g:ale_enabled = 1
autocmd FileType python let g:ale_enabled = 1


" coc mods
" nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" :set completeopt-=preview " For No Previews
let g:LanguageClient_serverCommands = {
			\ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
			\ }
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)


let g:ale_linters_explicit = 0
" add babel
  "devDependencies": {
  "  @babel/core: ^7.6.0",
  "  @babel/node: ^7.8.0",
  "  @babel/preset-env: ^7.6.0",
  "  eslint: ^6.4.0",
  "  eslint-config-airbnb-base: ^14.0.0",
  "  eslint-plugin-import: ^2.18.2",
  "  eslint-plugin-jest: ^22.17.0",
  "  jest: ^24.9.0"
  "}
let g:ale_linters = {
			\ 'javascript': ['eslint'],
			\ 'javascriptreact': ['eslint'],
			\ 'typescript': ['eslint'],
			\ 'typescriptreact': ['eslint'],
			\ 'css': ['stylelint'],
			\ 'scss': ['stylelint'],
			\ 'html': ['htmlhint'],
			\ 'json': ['jsonlint'],
			\ 'markdown': ['markdownlint'],
			\ 'python': ['pylint'],
			\ 'sh': ['shellcheck'],
			\ 'vim': ['vint'],
			\ 'yaml': ['yamllint'],
			\ 'sql': ['sqlint'],
			\ }
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_standard_exec = 'eslint'

autocmd bufwritepost *.js silent !eslint % --fix

" snippets remap 
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"



nmap <F8> :TagbarToggle<CR>



" colorscheme
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




let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:webdevicons_enable_nerdtree = 1
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_theme='hybrid'

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle


nmap <F2> :StartBrowserSync <CR>
nmap <F3> :KillBrowserSync <CR>


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


set autoread
" disable copilot
let g:copilot#enabled = 0
set colorcolumn=80
" highlight text beyond 80 characters
highlight ColorColumn ctermbg=0 guibg=lightgrey 
hi ColorColumn ctermbg=0 guibg=lightgrey
call matchadd('ColorColumn', '\%81v', 100)

