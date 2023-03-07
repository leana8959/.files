vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- From THE one and only "Primeagen"
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move page down with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move page up with cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next with cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find last with cursor centered" })
vim.keymap.set("n", "<leader>pv", ":Explore<CR>", { desc = "Display file explorer" })
