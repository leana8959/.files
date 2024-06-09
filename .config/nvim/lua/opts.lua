local o = vim.o

o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"

o.expandtab = true

o.wrap = false -- Slows the editor
o.linebreak = true
o.breakindent = true
o.filetype = "on"

o.swapfile = false
o.backup = false
o.undofile = true

o.termguicolors = true
o.mouse = "a"

o.autoindent = true
o.smartindent = true

o.scrolloff = 3

o.colorcolumn = "80"

-- for UFO
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

o.winbar = "%{%v:lua.require'winbar'.eval()%}"

o.showmode = false

vim.opt.listchars = { tab = "│ ", trail = "␣" }
o.list = true
