require "color-picker".setup { -- for changing icons & mappings
    ["icons"]                      = { "-", "·" },
    ["border"]                     = "rounded",
    ["background_highlight_group"] = "NormalFloat",
    ["border_highlight_group"]     = "FloatBorder",
    ["text_highlight_group"]       = "Normal",

    ["keymap"]                     = {
        ["H"] = "<Plug>ColorPickerSlider5Decrease",
        ["L"] = "<Plug>ColorPickerSlider5Increase",
    },
}
