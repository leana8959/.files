vim.keymap.set('n', "<leader>G", ":Git<CR>5<Down>", { desc = "open fugitive" })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "fugitive" },
	callback = function()
		vim.keymap.set("n", "<leader>G", ":q<CR>", { desc = "close fugitive", buffer = true })
	end,
})

vim.keymap.set('n', "<leader>gb", ":Git blame<CR>", { desc = "open fugitive blame" })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "fugitiveblame" },
	callback = function()
		vim.keymap.set("n", "<leader>gb", ":q<CR>", { desc = "close fugitive blame", buffer = true })
	end,
})
