vim.cmd.colorscheme "nordic"

local use_light = function()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			-- LSP window border color
			vim.cmd("highlight NormalFloat guibg=white")
			vim.cmd("highlight FloatBorder guifg=black guibg=white")

			-- Tune virtual text colors
			-- vim.cmd ("highlight DiagnosticError gui=bold")
			-- vim.cmd ("highlight DiagnosticWarn gui=italic")
			-- vim.cmd ("highlight DiagnosticInfo guibg=black guibg=italic")
			-- vim.cmd ("highlight DiagnosticHint guibg=black")

			-- TreesitterContext border
			vim.cmd("highlight TreesitterContext guibg=#EEEEEE")
			vim.cmd("highlight TreesitterContextBottom guibg=#EEEEEE gui=underline guisp=Grey")

			-- Diff colors override
			vim.cmd("highlight DiffAdd guibg=#f0f0f0")
			vim.cmd("highlight DiffChange guibg=#f0f0f0")
			vim.cmd("highlight DiffDelete guibg=#f0f0f0")
			vim.cmd("highlight DiffText guibg=#f0f0f0")
			vim.cmd("highlight DiffAdded guibg=#f0f0f0")
			vim.cmd("highlight DiffFile guibg=#f0f0f0")
			vim.cmd("highlight DiffNewFile guibg=#f0f0f0")
			vim.cmd("highlight DiffLine guibg=#f0f0f0")
			vim.cmd("highlight DiffRemoved guibg=#f0f0f0")
		end,
		group = vim.api.nvim_create_augroup("MyColorOverride", { clear = true }),
		pattern = "*",
	})

	vim.o.background = "light"
end

local use_dark = function()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			-- LSP window border color
			vim.cmd("highlight NormalFloat guibg=black")
			vim.cmd("highlight FloatBorder guifg=white guibg=black")

			-- Tune virtual text colors
			-- vim.cmd "highlight DiagnosticError gui=bold"
			-- vim.cmd "highlight DiagnosticWarn gui=italic"
			-- vim.cmd "highlight DiagnosticInfo guifg=white guibg=black"
			-- vim.cmd "highlight DiagnosticHint guifg=white guibg=black"

			-- TreesitterContext border
			vim.cmd("highlight TreesitterContext guibg=#3e444f")
			vim.cmd("highlight TreesitterContextBottom  guibg=#3e444f gui=underline guisp=LightGrey")

			-- Diff colors override
			vim.cmd("highlight DiffAdd guibg=#303030")
			vim.cmd("highlight DiffChange guibg=#303030")
			vim.cmd("highlight DiffDelete guibg=#303030")
			vim.cmd("highlight DiffText guibg=#303030")
			vim.cmd("highlight DiffAdded guibg=#303030")
			vim.cmd("highlight DiffFile guibg=#303030")
			vim.cmd("highlight DiffNewFile guibg=#303030")
			vim.cmd("highlight DiffLine guibg=#303030")
			vim.cmd("highlight DiffRemoved guibg=#303030")
		end,
		group = vim.api.nvim_create_augroup("MyColorOverride", { clear = true }),
		pattern = "*",
	})
	vim.o.background = "dark"
end

use_dark()
