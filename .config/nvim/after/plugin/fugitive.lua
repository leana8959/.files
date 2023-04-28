vim.keymap.set('n', "<leader>g",
	":Git<CR><Down><Down><Down><Down><Down>",
	{ desc = "open fugitive" }
)

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "fugitive" },
	callback = function()
		vim.keymap.set("n", "<leader>g", ":q<CR>", { desc = "close fugitive", buffer = true })
	end,
})
