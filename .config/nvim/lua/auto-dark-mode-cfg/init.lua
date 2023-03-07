local auto_dark_mode = require "auto-dark-mode"

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.o.background = "dark"
		vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=white]]
		vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=black guibg=white]]
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
	end,
	set_light_mode = function()
		vim.o.background = "light"
		vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=black]]
		vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=black]]
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
	end,
})
auto_dark_mode.init()
