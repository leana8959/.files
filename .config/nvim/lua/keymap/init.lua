vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- From THE one and only "Primeagen"
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set('n', "<C-d>", "<C-d>zz", { desc = "Move page down with cursor centered" })
vim.keymap.set('n', "<C-u>", "<C-u>zz", { desc = "Move page up with cursor centered" })
vim.keymap.set('n', "n", "nzzzv", { desc = "Find next with cursor centered" })
vim.keymap.set('n', "N", "Nzzzv", { desc = "Find last with cursor centered" })

vim.keymap.set('n', "<leader>pv", function() vim.cmd("Explore") end, { desc = "Show file explorer" })

vim.keymap.set('n', "J", "mzJ`z", { desc = "Join line below without moving cursor" })

vim.keymap.set({ 'n', 'x', 'v' }, "<leader>p", '"_dP', { desc = "Paste without copying selected" })
vim.keymap.set({ 'n', 'x', 'v' }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ 'n', 'x', 'v' }, "<leader>d", '"_d', { desc = "Delete without cutting" })

vim.keymap.set('n', "Q", "<nop>", { desc = "It's the worse place in the universe" })

