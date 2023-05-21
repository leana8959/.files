require "lualine".setup({
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
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
    lualine_b = { 'diagnostics' },
    lualine_c = {
      'progress',
      { 'filename', newfile_status = true, path = 3 }
    },
    lualine_x = {},
    lualine_y = { 'diff' },
    lualine_z = { 'branch' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 4 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  tabline = {},
  extensions = {}
})
