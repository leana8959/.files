vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- From THE one and only "Primeagen"
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>pv", function() vim.cmd("Explore") end)

map("n", "J", "mzJ`z")

map({ "n", "x", "v" }, "<leader>d", '"_d')
map({ "n", "x", "v" }, "<leader>c", '"_dc')
map({ "n", "x", "v" }, "<leader>p", '"_dP')
map({ "n", "x", "v" }, "<leader>y", '"+y')

map("n", "Q", "<nop>")

map("n", "<leader>nf", function() vim.cmd("enew") end)

map("c", "#lm", [[\{-}]])
map("c", "#capl", [[\(.\{-}\)]])
map("c", "#capm", [[\(.*\)]])

map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<Down>", "g<Down>")
map("n", "<Up>", "g<Up>")

map("n", "<leader>w", function() vim.cmd.setlocal("invwrap") end)
map("n", "<leader>hg", function() vim.cmd("TSHighlightCapturesUnderCursor") end)
