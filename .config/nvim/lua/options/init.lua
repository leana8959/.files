-- UI
vim.o.hlsearch = false
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 500
vim.o.termguicolors = true
vim.o.completeopt = "menu,preview"
vim.o.scrolloff = 8

vim.wo.signcolumn = "yes"
vim.wo.number = true

vim.opt.wrap = true
vim.opt.backup = false

vim.cmd "colorscheme one-nvim"
vim.o.background = "light"
vim.opt.guifont = { "Cascadia Code:h15" }

vim.cmd("filetype plugin on")
vim.g.sleuth_default_indent = "2"

-- Tabwidth and shit
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'lua', 'scala'
	},
	callback = function()
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
		vim.opt.tabstop = 2
	end,
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'rust', 'fish', 'python'
	},
	callback = function()
		vim.opt.shiftwidth = 4
		vim.opt.softtabstop = 4
		vim.opt.tabstop = 4
	end,
})
