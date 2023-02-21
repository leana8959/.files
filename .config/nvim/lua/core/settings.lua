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

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---- From THE one and only "Primeagen"
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")

---- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)





