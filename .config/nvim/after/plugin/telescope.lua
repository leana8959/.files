local telescope = require "telescope"
local actions = require "telescope.actions"
local themes = require "telescope.themes"
local config = require "telescope.config"

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden") -- search hidden
table.insert(vimgrep_arguments, "--glob")   -- ignore git
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
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
        }
    }
}

-- Enable telescope fzf native, if installed
pcall(require "telescope".load_extension, 'fzf')

local builtin = require "telescope.builtin"
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/',
    function() builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = false }) end,
    { desc = '[/] Fuzzily search in current buffer]' }
)
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search [A]ll [F]iles' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Search [B]uffers' })
