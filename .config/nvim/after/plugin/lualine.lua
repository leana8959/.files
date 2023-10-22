local function diagnostic_message()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local ds = vim.diagnostic.get(0, { lnum = row - 1 })
  if #ds >= 1 then
    return ds[1].message
  else
    return ""
  end
end

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
    lualine_b = { "diagnostics", diagnostic_message },
    lualine_c = { "navic", },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "progress" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { "diagnostics", diagnostic_message },
    lualine_c = { "navic", },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "progress" }
  },
  winbar = {},
  inactive_winbar = {},
  tabline = {},
  extensions = {}
})
