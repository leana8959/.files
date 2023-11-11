local ts                = require "telescope"
local actions           = require "telescope.actions"
local themes            = require "telescope.themes"
local config            = require "telescope.config"
local builtin           = require "telescope.builtin"
local map               = vim.keymap.set

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden") -- search hidden
table.insert(vimgrep_arguments, "--glob")   -- ignore git
table.insert(vimgrep_arguments, "!**/.git/*")

ts.setup {
    defaults = {
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require "telescope".load_extension, "fzf")


map("n", "<leader>/",
    function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = false })
    end
)
map("n", "<leader>sf", builtin.find_files)
map("n", "<leader>gf", builtin.git_files)
map("n", "<leader>?", builtin.help_tags)
map("n", "<leader>sw", builtin.grep_string)
map("n", "<leader>sg", builtin.live_grep)
map("n", "<leader>sd", builtin.diagnostics)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>b", builtin.buffers)
