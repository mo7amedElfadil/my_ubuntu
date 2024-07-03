-- bring `vim-plug` to lua
local Plug = vim.fn['plug#'];

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection clipboard',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection clipboard -o',
    },
    cache_enabled = 0,
  }
end

--------- IMPORT CUSTOM PLUGINS --------------
-- set map leader
vim.g.mapleader = ','
-- script loads once mapping is defined
vim.api.nvim_set_keymap('v', '<leader>,', ":lua require('comment').comment_block()<CR>",
{noremap = true, silent = true, desc = 'comment block'})
-- defer script loading until mapping executed
vim.keymap.set('n', '<leader>,', function() require('comment').comment_line() end,
{noremap = true, silent = true, desc = 'comment one line'})

-- sql capitalize
vim.keymap.set('n', '<leader>gq', function () require('sqlcap').capitalize() end,
{noremap = true, silent = true, desc = 'capitalize sql keywords'})

-- copilot keybindings
-- enable copilot by remapping :Copilot enable to <leader>ce
map('n', '<leader>ce', ':Copilot enable<CR>', {desc = 'enable copilot'})
-- enable copilot by remapping :Copilot disable to <leader>cd
map('n', '<leader>cd', ':Copilot disable<CR>', {desc = 'disable copilot'})




---------- IMPORTING REMOTE PLUGINS ----------
--
vim.call('plug#begin');

-- themesthemesthemesthemes
Plug 'folke/tokyonight.nvim'

Plug 'https://github.com/rafi/awesome-vim-colorschemes'

-- neovim lsp config
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

-- auto completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip' -- For vsnip users.
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'-- For luasnip users.
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'SirVer/ultisnips'-- For ultisnips users.
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'dcampos/nvim-snippy'-- For snippy users.
Plug 'dcampos/cmp-snippy'

Plug 'junegunn/vim-easy-align'

-- Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

-- Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

-- On-demand loading
Plug('preservim/nerdtree', { on = 'NERDTreeToggle'});
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' });
Plug 'stevearc/aerial.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' });
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'});

-- Using a non-default branch
Plug('rdnetto/YCM-Generator', { branch = 'stable' })

-- Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug('fatih/vim-go', { tag = '*' });

-- Plugin options
Plug('nsf/gocode', { tag = 'v.20150303', rtp = 'vim' });

-- Plugin outside ~/.vim/plugged with post-update hook
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = './install --all' });

-- Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug('iamcco/markdown-preview.nvim', { ['do'] = ':call mkdp#util#install()', ['for'] = 'markdown', ['on'] = 'MarkdownPreview' });

-- icons
Plug 'ryanoasis/vim-devicons'

-- status lines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- to disply airline sections
Plug 'tpope/vim-fugitive'

-- utils
Plug 'http://github.com/tpope/vim-surround' 
Plug 'https://github.com/ap/vim-css-color' 
Plug 'https://github.com/tpope/vim-commentary' 


-- plugins import ends here
vim.call('plug#end');

-- LSP CONFIGURATION --
require('lsp')

-- AUTO-COMPLETION --
require('auto_cmp')

-- KEY BINDINGS --
require('keybindings')


-- source some vim config
vim.cmd("source ~/.vimrc");
