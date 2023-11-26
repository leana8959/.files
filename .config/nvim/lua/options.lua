local opt          = vim.opt

opt.hlsearch       = false
opt.incsearch      = true

opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.signcolumn     = "yes"

opt.tabstop        = 4
opt.expandtab      = true
opt.shiftwidth     = 4

opt.wrap           = false -- Slows the editor
opt.linebreak      = true
opt.breakindent    = true
opt.filetype       = "on"

opt.swapfile       = false
opt.backup         = false
opt.undofile       = true

opt.termguicolors  = true
opt.mouse          = "a"

opt.ignorecase     = true
opt.smartcase      = true
opt.autoindent     = true
opt.smartindent    = true

opt.scrolloff      = 3

opt.colorcolumn    = "80"

opt.foldlevel      = 99
opt.foldlevelstart = 99
opt.foldenable     = true

opt.winbar         = "%{%v:lua.require'winbar'.eval()%}"

opt.showmode       = false

opt.listchars      = { tab = "│ ", trail = "␣" }
opt.list           = true

vim.g.netrw_banner = 0
