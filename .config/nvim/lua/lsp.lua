require("mason").setup()
local lsp_mason = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.pyright.setup{}


lsp_mason.setup {
	ensure_installed = {
		'eslint',
		'tsserver',
		'tailwindcss',
		'pyright'
	},
}

lsp_mason.setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.keymap.set('n', 'F', vim.lsp.buf.hover, { buffer = bufnr })
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
				vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr })
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
				vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr })
			end,
		}
	end,
	 -- Custom handler for ESLint
  ['eslint'] = function()
    lspconfig.eslint.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Auto-fix ESLint issues on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })

        -- ESLint keymaps and formatting
        vim.keymap.set('n', 'F', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr })
      end,
      settings = {
        format = { enable = true },
        codeActionOnSave = {
          enable = true,
          mode = "all", -- Auto-fix ESLint errors on save
        },
      },
    }
  end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- ['pylsp'] = function()
	-- 	lspconfig.pylsp.setup {
	-- 		settings = {
	-- 			pylsp = {
	-- 				plugins = {
	-- 					pylint = { enabled = true, executable = 'pylint', }
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- end,
}

