vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set


map("v", "J", ":m '>+1<CR>gv=gv") -- Move up
map("v", "K", ":m '<-2<CR>gv=gv") -- Move down

map("n", "<C-d>", "<C-d>zz")      -- Centered motions
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

map({ "n", "x", "v" }, "<leader>d", '"_d') -- Better clipboard
map({ "n", "x", "v" }, "<leader>c", '"_dc')
map({ "n", "x", "v" }, "<leader>p", '"_dP')
map({ "n", "x", "v" }, "<leader>y", '"+y')

map("n", "j", "gj") -- linewrap jk
map("n", "k", "gk")
map("n", "<Down>", "g<Down>")
map("n", "<Up>", "g<Up>")

map("n", "<leader>pv", function() vim.cmd("Explore") end) -- Project View

map("n", "<leader>nf", function() vim.cmd("enew") end)    -- New File
map("n", "<leader>so", function() vim.cmd("so %") end)    -- Source buffer

map("c", "#capl", [[\(.\{-}\)]])                          -- helpers in regex
map("c", "#capm", [[\(.*\)]])

map("n", "<leader>gP", function() vim.cmd("G push") end) -- Git
map("n", "<leader>gp", function() vim.cmd("G pull") end)

map("n", "<leader>+x", function() vim.cmd("!chmod +x %") end) -- Permission
map("n", "<leader>-x", function() vim.cmd("!chmod -x %") end)

map("n", "<leader>w", function() vim.cmd.setlocal("invwrap") end) -- linewrap

map("n", "<leader>ta", function() vim.cmd("Tabularize /=") end)   -- Alignment
map("n", "<leader>tc", function() vim.cmd("Tabularize /:") end)
map("n", "<leader>tC", function() vim.cmd("Tabularize trailing_c_comments") end)

map("n", "<leader>hg", function() vim.cmd("Inspect") end) -- Highlight Group

map("n", "<leader>tw", function() vim.cmd("Twilight") end)

map("n", "Q", "<nop>") -- *do not* repeat the last recorded register [count] times.
