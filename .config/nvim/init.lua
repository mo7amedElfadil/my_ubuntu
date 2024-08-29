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



---------- IMPORTING REMOTE PLUGINS ----------
--
vim.call('plug#begin');

-- themesthemesthemesthemes
Plug 'folke/tokyonight.nvim'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
-- image preview
-- Plug 'edluffy/hologram.nvim'

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

-- git decorations implemented
Plug 'lewis6991/gitsigns.nvim'



Plug 'junegunn/vim-easy-align'

-- Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'kdheepak/lazygit.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
-- Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

-- On-demand loading
Plug('preservim/nerdtree', { on = 'NERDTreeToggle'});
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' });
Plug 'stevearc/aerial.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' });
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'});

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' });
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

-- VIM GIT SIGNS --
require('gitsigns').setup()
-- require('hologram').setup{
-- 	width = 80,
-- 	height = 60,
--     auto_display = true -- WIP automatic markdown image display, may be prone to breaking
-- }
require('telescope').load_extension('lazygit')

require('noice').setup({
  views = {
    cmdline_popup = {
      position = {
        row = 20,
        col = "50%",
      },
      size = {
        width = "auto",
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 23,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    {
      filter = { event = "notify", find = "No information available" },
      opts = { skip = true },
    },
    {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "lua_ls"
        end,
      },
      opts = { skip = true },
    },
  },
  presets = {
    lsp_doc_border = true,
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
  },
})

-- Configure nvim-notify
require('notify').setup({
  timeout = 800, -- Adjust this value as needed
})
-- source some vim config
vim.cmd("source ~/.vimrc");
