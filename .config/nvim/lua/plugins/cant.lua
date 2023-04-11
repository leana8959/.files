return {
	-- Can't live without
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "-" },
				changedelete = { text = "~" },
				untracked = { text = "·" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 2500,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 0,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		},
	},
	{ "lukas-reineke/indent-blankline.nvim", opts = {
		char = "┊",
		show_trailing_blankline_indent = false,
	} },
	{
		"lukoshkin/trailing-whitespace",
		opts = {

			patterns = { "\\s\\+$" },
			palette = { markdown = "#CCCCCC" },
			default_color = "#EEEEEE",
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()

			local ui = require("harpoon.ui")
			local mark = require("harpoon.mark")

			-- add and view
			vim.keymap.set({ "n", "i" }, "<A-a>", function()
				mark.add_file()
			end, { desc = "add file to harpoon" })
			vim.keymap.set({ "n", "i" }, "<A-e>", function()
				ui.toggle_quick_menu()
			end, { desc = "show harpoon menu" })

			-- switch it up!
			vim.keymap.set({ "n", "i" }, "<A-h>", function()
				ui.nav_file(1)
			end, { desc = "harpoon 1 (the magic finger)" })
			vim.keymap.set({ "n", "i" }, "<A-t>", function()
				ui.nav_file(2)
			end, { desc = "harpoon 2" })
			vim.keymap.set({ "n", "i" }, "<A-n>", function()
				ui.nav_file(3)
			end, { desc = "harpoon 3" })
			vim.keymap.set({ "n", "i" }, "<A-s>", function()
				ui.nav_file(4)
			end, { desc = "harpoon 4" })
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>G", vim.cmd.Git, { desc = "open fugitive" })
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				signs = true, -- show icons in the signs column
				sign_priority = 10, -- sign priority
				-- keywords recognized as todo comments
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = "!", color = "warning" },
					WARN = { icon = "!", color = "warning", alt = { "WARNING", "XXX" } },
					NOTE = { icon = "·", color = "hint", alt = { "INFO" } },
					TEST = { icon = "T", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
					Q = { icon = "?", color = "warning" },
				},
				gui_style = {
					fg = "NONE", -- The gui style to use for the fg highlight group.
					bg = "BOLD", -- The gui style to use for the bg highlight group.
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- highlighting of the line containing the todo comment
				-- * before: highlights before the keyword (typically comment characters)
				-- * keyword: highlights of the keyword
				-- * after: highlights after the keyword (todo text)
				highlight = {
					multiline = true, -- enable multine todo comments
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					multiline_context = 8, -- extra lines that will be re-evaluated when changing a line
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
					after = "bg", -- "fg" or "bg" or empty
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of named colors where we try to extract the guifg from the
				-- list of highlight groups or use the hex color if hl not found as a fallback
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
					info = { "DiagnosticInfo", "#2563EB" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					-- regex that will be used to match keywords.
					-- don't replace the (KEYWORDS) placeholder
					pattern = [[\b(KEYWORDS):]], -- ripgrep regex
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			"<leader>u",
			"UndotreeToggle",
			desc = "Toggle undotree view",
		},
	},
	"rafamadriz/friendly-snippets",
	{
		"mizlan/iswap.nvim",
		config = function()
			require("iswap").setup({
				-- The keys that will be used as a selection, in order
				-- ('asdfghjklqwertyuiopzxcvbnm' by default)
				-- keys = "aoeuhtns",

				-- Grey out the rest of the text when making a selection
				-- (enabled by default)
				grey = "disable",

				-- Highlight group for the sniping value (asdf etc.)
				-- default 'Search'
				-- hl_snipe = 'ErrorMsg',

				-- Highlight group for the visual selection of terms
				-- default 'Visual'
				-- hl_selection = 'WarningMsg',

				-- Highlight group for the greyed background
				-- default 'Comment'
				-- hl_grey = 'LineNr',

				-- Post-operation flashing highlight style,
				-- either 'simultaneous' or 'sequential', or false to disable
				-- default 'sequential'
				-- flash_style = false,

				-- Highlight group for flashing highlight afterward
				-- default 'IncSearch'
				-- hl_flash = 'ModeMsg',

				-- Move cursor to the other element in ISwap*With commands
				-- default false
				-- move_cursor = true,

				-- Automatically swap with only two arguments
				-- default nil
				autoswap = true,

				-- Other default options you probably should not change:
				debug = nil,
				hl_grey_priority = "1000",
			})

			vim.keymap.set("n", "s<Left>", ":ISwapNodeWithLeft<CR>", { desc = "Swap argument with left" })
			vim.keymap.set("n", "s<Right>", ":ISwapNodeWithRight<CR>", { desc = "Swap argument with right" })
		end,
	},
	{ "wintermute-cell/gitignore.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
}
