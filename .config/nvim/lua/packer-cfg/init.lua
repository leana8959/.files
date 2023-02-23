local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
	vim.cmd "packadd packer.nvim"
end

require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use "Th3Whit3Wolf/one-nvim"
	use "ThePrimeagen/vim-be-good"

	use "numToStr/Comment.nvim"
	use "lewis6991/gitsigns.nvim"
	use "lukas-reineke/indent-blankline.nvim"
	use "nvim-lualine/lualine.nvim"

	use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } }
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }

	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require "nvim-treesitter.install".update({ with_sync = true })
			ts_update()
		end,
	}
	use { "neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	}
	use { "hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
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
