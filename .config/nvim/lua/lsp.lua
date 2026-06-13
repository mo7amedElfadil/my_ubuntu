require("mason").setup()
local lsp_mason = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()


lsp_mason.setup {
	ensure_installed = {
		'eslint',
		'tsserver',
		'tailwindcss',
		'pyright'
	},
}

if type(lsp_mason.setup_handlers) == "function" then
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
        -- Auto-fix ESLint issues on save (only if command exists)
        if vim.fn.exists(":EslintFixAll") == 2 then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end

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
else
  -- Compatibility: older mason-lspconfig versions may not expose setup_handlers
  local installed_servers
  if type(lsp_mason.get_installed_servers) == "function" then
    installed_servers = lsp_mason.get_installed_servers()
  else
    installed_servers = { 'eslint', 'tsserver', 'tailwindcss', 'pyright' }
  end

  local function on_attach_common(client, bufnr)
    vim.keymap.set('n', 'F', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr })
  end

  for _, server_name in ipairs(installed_servers) do
    if server_name == 'eslint' then
      lspconfig.eslint.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          if vim.fn.exists(":EslintFixAll") == 2 then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end
          on_attach_common(client, bufnr)
        end,
        settings = {
          format = { enable = true },
          codeActionOnSave = { enable = true, mode = "all" },
        },
      }
    else
      if lspconfig[server_name] ~= nil then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach_common,
        }
      end
    end
  end
end

