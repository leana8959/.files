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
	-- Fun stuff
	"ThePrimeagen/vim-be-good",
	"Eandrju/cellular-automaton.nvim",

	-- Colorschemes
	"Th3Whit3Wolf/one-nvim",
	{ "catppuccin/nvim",            name = "catppuccin" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly",  lazy = false, priority = 1000 },
	{ "nordtheme/vim",              name = "nord" },
	{ "rose-pine/neovim",           name = "rose-pine" },
	{ "savq/melange-nvim",          name = "melange" },
	{ "fcpg/vim-fahrenheit",        name = "fahrenheit" },
	{ "adigitoleo/vim-mellow",      name = "mellow" },
	{ "neanias/everforest-nvim",    name = "everforest" },

	-- Nice to have
	"tpope/vim-sleuth",
	"mg979/vim-visual-multi",
	"nvim-lualine/lualine.nvim",
	"norcalli/nvim-colorizer.lua",
	"simrat39/symbols-outline.nvim",
	"ellisonleao/glow.nvim",
	"nvim-tree/nvim-web-devicons",
	{ "akinsho/toggleterm.nvim",        version = "*" },

	-- Can't live without
	"folke/zen-mode.nvim",
	"numToStr/Comment.nvim",
	"tpope/vim-surround",
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lukoshkin/trailing-whitespace",
	"windwp/nvim-autopairs",
	"tpope/vim-fugitive",
	"mbbill/undotree",
	"rafamadriz/friendly-snippets",
	"mizlan/iswap.nvim",
	{ "ThePrimeagen/harpoon",           dependencies = "nvim-lua/plenary.nvim" },
	{ "folke/todo-comments.nvim",       dependencies = "nvim-lua/plenary.nvim" },
	{ "wintermute-cell/gitignore.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		}
	},

	-- Power tools
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1
	},
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
	install = { colorscheme = { "catppuccin" } },
})
