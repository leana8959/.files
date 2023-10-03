require "lualine".setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      statusline = { "fugitive" },
      winbar = { "fugitive" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = { "diagnostics" },
    lualine_c = {
      -- { "filename", newfile_status = true, path = 1 },
      { "navic" }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "progress" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { { "filename", path = 4 } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  tabline = {},
  extensions = {}
})
