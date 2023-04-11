return {
	-- Nice to have
	"tpope/vim-sleuth",
	"mg979/vim-visual-multi",
	{ "norcalli/nvim-colorizer.lua", config = true },
	{
		"ellisonleao/glow.nvim",
		opts = {
			glow_path = "glow", -- will be filled automatically with your glow bin in $PATH, if any
			install_path = "~/.local/bin", -- default path for installing glow binary
			border = "shadow", -- floating window border config
			style = "light", -- filled automatically with your current editor background, you can override using glow json style
			pager = false,
			width = 80,
			height = 100,
			width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
			height_ratio = 0.7,
		},
	},
	"nvim-tree/nvim-web-devicons",
	{
		"akinsho/toggleterm.nvim",
		tag = "*",
		opts = {
			open_mapping = "<C-`>",
			size = 20,
		},
	},
}
