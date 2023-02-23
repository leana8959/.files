require('nvim-treesitter.configs').setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"vim",
		"help",
		"rust",
		"scala",
		"python"
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- set to `false` to disable one of the mappings
			init_selection = "false",
			scope_incremental = "false",
			node_incremental = "<A-Up>",
			node_decremental = "<A-Down>",
		},
	},
	refactor = {
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr"
			}
		}
	}
})
