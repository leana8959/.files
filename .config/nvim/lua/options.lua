vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.filetype = "on"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- wrapping makes the editor slow, turn it off by default
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

vim.opt.scrolloff = 14

vim.opt.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex" },
	callback = function() vim.opt_local.wrap = true end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function() vim.cmd("set iskeyword+=&") end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "fish" },
	callback = function() vim.cmd("set iskeyword+=$") end,
})
