require("harpoon").setup {}

local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

-- add and view
vim.keymap.set({ 'n', 'i' },
    '<A-a>',
    function() mark.add_file() end, { noremap = true, desc = "add file to harpoon" }
)
vim.keymap.set({ 'n', 'i' },
    '<A-e>',
    function() ui.toggle_quick_menu() end,
    { noremap = true, desc = "show harpoon menu" }
)

-- switch it up!
vim.keymap.set({ 'n', 'i' },
    '<A-h>',
    function() ui.nav_file(1) end, { noremap = true, desc = "harpoon 1 (the magic finger)" }
)
vim.keymap.set({ 'n', 'i' },
    '<A-t>',
    function() ui.nav_file(2) end, { noremap = true, desc = "harpoon 2" }
)
vim.keymap.set({ 'n', 'i' },
    '<A-n>',
    function() ui.nav_file(3) end, { noremap = true, desc = "harpoon 3" }
)
vim.keymap.set({ 'n', 'i' },
    '<A-s>',
    function() ui.nav_file(4) end, { noremap = true, desc = "harpoon 4" }
)
