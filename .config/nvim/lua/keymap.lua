vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- From THE one and only "Primeagen"
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move page down with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move page up with cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next with cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find last with cursor centered" })

vim.keymap.set("n", "<leader>pv",
	function() vim.cmd("Explore") end,
	{ desc = "Show file explorer" }
)

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })

vim.keymap.set({ "n", "x", "v" }, "<leader>d", '"_d', { desc = "Delete without cutting" })
vim.keymap.set({ "n", "x", "v" }, "<leader>c", '"_dc', { desc = "Change without cutting" })
vim.keymap.set({ "n", "x", "v" }, "<leader>p", '"_dP', { desc = "Paste without copying selected" })
vim.keymap.set({ "n", "x", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })

vim.keymap.set("n", "Q", "<nop>", { desc = "It's the worse place in the universe" })

vim.keymap.set("n", "<leader>nf",
	function() vim.cmd("enew") end,
	{ desc = "Open new buffer" }
)

vim.keymap.set("c", "#lm", [[\{-}]], { desc = "[L]azy [M]atch" })
vim.keymap.set("c", "#capl", [[\(.\{-}\)]], { desc = "[CAP]ture [L]ess" })
vim.keymap.set("c", "#capm", [[\(.*\)]], { desc = "[CAP]ture [M]ore" })

vim.keymap.set("n", "j", "gj", { desc = "J that works with line wrap" })
vim.keymap.set("n", "k", "gk", { desc = "K that works with line wrap" })
vim.keymap.set("n", "<Down>", "g<Down>", { desc = "<Down> that works with line wrap" })
vim.keymap.set("n", "<Up>", "g<Up>", { desc = "<Up> that works with line wrap" })

vim.keymap.set("n", "<leader>w",
	function() vim.cmd.setlocal("invwrap") end,
	{ desc = "toggle wrap locally", silent = true }
)
vim.keymap.set("n", "<leader>hg",
	function()
		for _, v in ipairs(vim.treesitter.get_captures_at_cursor()) do print(v) end
	end,
	{ desc = "show highlight group at cursor", silent = true }
)
