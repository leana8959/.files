local cmp = require("cmp")
local luasnip = require("luasnip")

require "luasnip.loaders.from_vscode".lazy_load({ paths = { "./snippets" } })

-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('s', "<Tab>", function() require "luasnip".jump(1) end, opts)
-- vim.keymap.set('s', "<S-Tab>", function() require "luasnip".jump( -1) end, opts)

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs( -4),
		['<C-u>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
