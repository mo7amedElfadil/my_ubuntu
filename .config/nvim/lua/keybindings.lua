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
