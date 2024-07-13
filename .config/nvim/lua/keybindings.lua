-- custom functions to map keybindings
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

-- leader key
vim.g.mapleader = ','
-- tab navigation
vim.keymap.set('n', '<leader>t', '<cmd>tabn<CR>')

-- Mapping for lsp diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- fold code keymaps
vim.keymap.set('n', '-', '<cmd>foldclose<CR>', {desc = 'fold close'})

-- make current buffer executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {desc = 'set buffer to be executable'})
-- :!nautilus %:p:h
vim.keymap.set('n', '<leader>ex', '<cmd>!nautilus %:p:h<CR>', {desc = 'open directory in os'})

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- custom keybindings
-- 
-- copilot keybindings
-- enable copilot by remapping :Copilot enable to <leader>ce
map('n', '<leader>ce', ':Copilot enable<CR>', {desc = 'enable copilot'})
-- enable copilot by remapping :Copilot disable to <leader>cd
map('n', '<leader>cd', ':Copilot disable<CR>', {desc = 'disable copilot'})

-- create a new executable file 
map('n', '<leader>me', ':!chmod +x %<CR>', {desc = 'create new executable file'})

-- create wundo file using wundo command named as current file + .undo and close the current file
map('n', '<leader>qu', ':wundo %:p.undo<CR>:wq<CR>', {desc = 'create wundo file and close current file'})
-- rundo command to restore the file from wundo file
map('n', '<leader>ru', ':rundo %:p.undo<CR>', {desc = 'restore file from wundo file'})
