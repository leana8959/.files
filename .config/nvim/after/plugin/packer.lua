require "packer".startup(function(use)
	use "wbthomason/packer.nvim"

	-- Misc
	use "Th3Whit3Wolf/one-nvim"
	use "ThePrimeagen/vim-be-good"
	use "andweeb/presence.nvim"
	use "Eandrju/cellular-automaton.nvim"

	-- Nice to have
	use "tpope/vim-sleuth"
	use "mg979/vim-visual-multi"
	use "nvim-lualine/lualine.nvim"
	use "norcalli/nvim-colorizer.lua"
	use "simrat39/symbols-outline.nvim"
	use "ellisonleao/glow.nvim"
	use "nvim-tree/nvim-web-devicons"
	use { "akinsho/toggleterm.nvim", tag = '*' }

	-- Can't live without
	use "numToStr/Comment.nvim"
	use "ur4ltz/surround.nvim"
	use "lewis6991/gitsigns.nvim"
	use "lukas-reineke/indent-blankline.nvim"
	use "lukoshkin/trailing-whitespace"
	use "windwp/nvim-autopairs"
	use { "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } }
	use "tpope/vim-fugitive"
	use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
	use { "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" } }
	use "mbbill/undotree"
	use "rafamadriz/friendly-snippets"
	use "mizlan/iswap.nvim"

	-- Power tools
	use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } }
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }
	use { "nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require "nvim-treesitter.install".update({ with_sync = true })
			ts_update()
		end, }
	use "nvim-treesitter/nvim-treesitter-context"
	use "lukas-reineke/lsp-format.nvim"
	use { "neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	}
end)
