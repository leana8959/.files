require "mason".setup()
require "mason-lspconfig".setup({
	ensure_installed = {},
	automatic_installation = false
})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap = true, silent = true })

-- require "lsp-format".setup()
local on_attach = function(client, bufnr)
	-- require "lsp-format".on_attach(client)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError", { text = '', texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = '', texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = '·', texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = '·', texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })


-- Border setup
local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".default_capabilities(capabilities)
-- Spell check
local common_dictionary = {
	"Yu", "Hui", "Chiang",
	"ISTIC",
}
require "lspconfig".ltex.setup {
	on_attach = on_attach,
	cmd = { "ltex-ls" },
	filetypes = { "markdown", "text", "gitcommit" },
	settings = {
		ltex = {
			language = "auto",
			additionalRules = {
				motherTongue = "en-US"
			},
			trace = { server = "verbose" },
			dictionary = {
				["en-US"] = common_dictionary,
				["fr"] = common_dictionary
			},
		},
	},
	flags = { debounce_text_changes = 5000 },
	capabilities = capabilities,
}
-- JSON
require "lspconfig".jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- XML
require "lspconfig".lemminx.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- CSS
require "lspconfig".cssls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Lua
require "lspconfig".lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		lua = {
			formatting = {
				enable = true,
				indent = 2,
			}
		}
	},
}
-- Rust
require "lspconfig".rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Scala
require "lspconfig".metals.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Golang
require "lspconfig".gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Python
require "lspconfig".pylsp.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- C
require "lspconfig".clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
