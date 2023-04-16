local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("keymap")
require("options")

require("lazy").setup({
	-- Misc
	"Th3Whit3Wolf/one-nvim",
	{ "catppuccin/nvim",         name = "catppuccin" },
	"ThePrimeagen/vim-be-good",
	"Eandrju/cellular-automaton.nvim",

	-- Nice to have
	"tpope/vim-sleuth",
	"mg979/vim-visual-multi",
	"nvim-lualine/lualine.nvim",
	"norcalli/nvim-colorizer.lua",
	"simrat39/symbols-outline.nvim",
	"ellisonleao/glow.nvim",
	"nvim-tree/nvim-web-devicons",
	{ "akinsho/toggleterm.nvim", version = "*" },

	-- Can't live without
	"numToStr/Comment.nvim",
	"ur4ltz/surround.nvim",
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lukoshkin/trailing-whitespace",
	"windwp/nvim-autopairs",
	{ "ThePrimeagen/harpoon",     dependencies = { "nvim-lua/plenary.nvim" } },
	"tpope/vim-fugitive",
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "hrsh7th/nvim-cmp",         dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" } },
	"mbbill/undotree",
	"rafamadriz/friendly-snippets",
	"mizlan/iswap.nvim",
	"mfussenegger/nvim-dap",
	{ "wintermute-cell/gitignore.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

	-- Power tools
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim" }
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",
	"lukas-reineke/lsp-format.nvim",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	},
}, {
	install = { colorscheme = { "one-nvim" } },
})
