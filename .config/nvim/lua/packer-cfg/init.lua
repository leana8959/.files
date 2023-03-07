local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
	vim.cmd "packadd packer.nvim"
end

require "packer".startup(function(use)
	use "wbthomason/packer.nvim"

	-- Theme
	use "Th3Whit3Wolf/one-nvim"
	-- Vim interactive tutorial
	use "ThePrimeagen/vim-be-good"

	-- Symbols view
	use "simrat39/symbols-outline.nvim"

	-- Comment shortcut
	use "numToStr/Comment.nvim"

	-- Git diff symbols on the side
	use "lewis6991/gitsigns.nvim"

	-- Auto-indent new line
	use "lukas-reineke/indent-blankline.nvim"

	-- Highlight trailing whitespace
	use "lukoshkin/trailing-whitespace"

	-- Status bar
	use "nvim-lualine/lualine.nvim"

	-- File manager panel
	-- use "nvim-tree/nvim-tree.lua"

	-- Auto config tabsize
	use "tpope/vim-sleuth"

	-- Discord presence
	use "andweeb/presence.nvim"

	-- Auto-pair parentheses and more
	use "windwp/nvim-autopairs"

	-- Add/change/delete surrounding delimiter pairs
	use { "kylechui/nvim-surround", tag = "*" }

	-- Colorize hex color strings
	use "norcalli/nvim-colorizer.lua"

	-- Multicursor
	use "mg979/vim-visual-multi"

	-- Zen mode
	-- use "Pocco81/true-zen.nvim"

	-- Tab bar
	use { "romgrk/barbar.nvim", requires = { "kyazdani42/nvim-web-devicons" } }

	-- Grep / fuzzy finder
	use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } }
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }

	-- Git utilities, i.e. git blame
	use "tpope/vim-fugitive"

	-- Auto-complete
	use { "hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	}
	-- Auto-complete snippets
	use "rafamadriz/friendly-snippets"

	-- Highlight todo comments
	use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }

	-- Terminal
	use { "akinsho/toggleterm.nvim", tag = '*' }

	-- Start page
	use { "startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	}

	-- AST
	use { "nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require "nvim-treesitter.install".update({ with_sync = true })
			ts_update()
		end,
	}

	-- LSP
	use "lukas-reineke/lsp-format.nvim"
	use { "neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	}

	if is_bootstrap then
		require "packer".sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print "=================================="
	print "    Plugins are being installed"
	print "    Wait until Packer completes,"
	print "       then restart nvim"
	print "=================================="
	return
end
