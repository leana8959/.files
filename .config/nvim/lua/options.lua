vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.filetype = "on"

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- wrapping makes the editor EXTREMELY slow, turn it off by default
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.scrolloff = 5

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})


vim.cmd([[set listchars=tab:\ \ ,trail:␣]])
vim.opt.list = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex", "typst" },
	callback = function()
		vim.cmd("setlocal wrap")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function() vim.cmd("setlocal iskeyword+=&") end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "fish" },
	callback = function() vim.cmd("setlocal iskeyword+=$") end,
})

vim.filetype.add({ extension = { typ = "typst" } })
