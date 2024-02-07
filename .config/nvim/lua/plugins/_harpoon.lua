require "harpoon".setup()

local ui   = require "harpoon.ui"
local mark = require "harpoon.mark"
local map  = vim.keymap.set

-- add and view
map({ "n", "i" }, "<A-c>", function() mark.add_file() end)
map({ "n", "i" }, "<A-g>", function() ui.toggle_quick_menu() end)

-- switch it up!
map({ "n", "i" }, "<A-h>", function() ui.nav_file(1) end)
map({ "n", "i" }, "<A-t>", function() ui.nav_file(2) end)
map({ "n", "i" }, "<A-n>", function() ui.nav_file(3) end)
map({ "n", "i" }, "<A-s>", function() ui.nav_file(4) end)
map({ "n", "i" }, "<A-m>", function() ui.nav_file(5) end)
map({ "n", "i" }, "<A-w>", function() ui.nav_file(6) end)
map({ "n", "i" }, "<A-v>", function() ui.nav_file(7) end)
map({ "n", "i" }, "<A-z>", function() ui.nav_file(8) end)
