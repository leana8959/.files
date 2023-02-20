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


