require "mason".setup()
require "mason-lspconfig".setup {
	ensure_installed = {},
	automatic_installation = false
}
require "neodev".setup()

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "open diagnostic in a float window" })
vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev, { desc = "goto [P]revious [E]rror" })
vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, { desc = "goto [N]ext [E]rror" })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = "show [E]rror [L]ocations" })

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*`
	local bufopts = { buffer = bufnr }

	local rename = function()
		vim.ui.input(
			{ prompt = "Rename symbol: " },
			function(new_name) if (new_name ~= nil) then vim.lsp.buf.rename(new_name) end end)
	end

	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gu', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, bufopts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', '<leader>r', rename, bufopts)
end

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError", { text = 'E', texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = 'W', texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = 'H', texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
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
	"Yu", "Hui", "Léana", "Chiang",
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
	flags = { debounce_text_changes = 10000 },
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
	cmd = { "rustup", "run", "stable", "rust-analyzer" }
}
-- Markdown
require "lspconfig".marksman.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- TOML
require "lspconfig".taplo.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Java
require "lspconfig".jdtls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Scala
require "lspconfig".metals.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Haskell
require "lspconfig".hls.setup {
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
-- HTML
require "lspconfig".html.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "xhtml" },
}
