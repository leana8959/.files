local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#999999" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#666666" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#333333" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#222222" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#111111" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#050505" })
end)

require "ibl".setup {
    indent = { highlight = highlight, },
}
