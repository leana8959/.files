local harpoon = require("harpoon")
local map = vim.keymap.set

harpoon:setup {
    settings = { save_on_toggle = true },
}

-- add and view
map({ "n", "i" }, "<A-c>", function() harpoon:list():add() end)
map({ "n", "i" }, "<A-g>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- switch it up!
map({ "n", "i" }, "<A-h>", function() harpoon:list():select(1) end)
map({ "n", "i" }, "<A-t>", function() harpoon:list():select(2) end)
map({ "n", "i" }, "<A-n>", function() harpoon:list():select(3) end)
map({ "n", "i" }, "<A-s>", function() harpoon:list():select(4) end)
map({ "n", "i" }, "<A-m>", function() harpoon:list():select(5) end)
map({ "n", "i" }, "<A-w>", function() harpoon:list():select(6) end)
map({ "n", "i" }, "<A-v>", function() harpoon:list():select(7) end)
map({ "n", "i" }, "<A-z>", function() harpoon:list():select(8) end)
