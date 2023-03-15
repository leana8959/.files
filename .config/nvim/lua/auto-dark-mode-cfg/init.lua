local auto_dark_mode = require "auto-dark-mode"

Set_light_mode = function()
	vim.api.nvim_create_autocmd(
		"ColorScheme",
		{
			callback = function()
				vim.cmd "highlight NormalFloat guibg=white"
				vim.cmd "highlight FloatBorder guifg=black guibg=white"

				-- vim.cmd "highlight DiagnosticError gui=bold"
				-- vim.cmd "highlight DiagnosticWarn gui=italic"
				-- vim.cmd "highlight DiagnosticInfo guibg=black guibg=italic"
				-- vim.cmd "highlight DiagnosticHint guibg=black"

				vim.cmd "highlight TreesitterContext guibg=#EEEEEE"
				vim.cmd "highlight TreesitterContextBottom guibg=#EEEEEE gui=underline guisp=Grey"
			end,
			group = vim.api.nvim_create_augroup("MyColorOverride", { clear = true }),
			pattern = '*',
		}
	)

	vim.o.background = "light"
end

Set_dark_mode = function()
	vim.api.nvim_create_autocmd(
		"ColorScheme",
		{
			callback = function()
				vim.cmd "highlight NormalFloat guibg=black"
				vim.cmd "highlight FloatBorder guifg=white guibg=black"

				-- vim.cmd "highlight DiagnosticError gui=bold"
				-- vim.cmd "highlight DiagnosticWarn gui=italic"
				-- vim.cmd "highlight DiagnosticInfo guifg=white guibg=black"
				-- vim.cmd "highlight DiagnosticHint guifg=white guibg=black"

				vim.cmd "highlight TreesitterContext guibg=#555555"
				vim.cmd "highlight TreesitterContextBottom  guibg=#555555 gui=underline guisp=LightGrey"
			end,
			group = vim.api.nvim_create_augroup("MyColorOverride", { clear = true }),
			pattern = '*',
		}
	)

	vim.o.background = "dark"
end

-- Use light by default
Set_light_mode()

auto_dark_mode.setup({
	update_interval = 5000,
	set_light_mode = Set_light_mode,
	set_dark_mode = Set_dark_mode,
})
auto_dark_mode.init()
