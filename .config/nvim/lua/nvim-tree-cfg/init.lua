require("nvim-tree").setup({
	view = {
		number = true,
		relativenumber = true,
	}
})

vim.keymap.set("n", "<leader><space>", function() require('nvim-tree.api').tree.toggle() end)
