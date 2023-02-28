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
vim.opt.linebreak = true
vim.opt.backup = false

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

vim.cmd "colorscheme one-nvim"
vim.o.background = "light"
vim.opt.guifont = { "Cascadia Code:h15" }
