require "treesitter-context".setup({
    enable              = true,      -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines           = 7,         -- How many lines the window should span. Values <                                     = 0 mean no limit.
    min_window_height   = 0,         -- Minimum editor window height to enable context. Values <                                    = 0 mean no limit.
    line_numbers        = true,
    multiline_threshold = 20,        -- Maximum number of lines to collapse for a single context line
    trim_scope          = 'outer',   -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode                = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
    zindex              = 20,        -- The Z-index of the context window
})
