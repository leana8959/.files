require "harpoon".setup()

local ui = require "harpoon.ui"
local mark = require "harpoon.mark"

-- add and view
vim.keymap.set({ 'n', 'i' }, '<A-a>', function() mark.add_file() end, { desc = "add file to harpoon" })
vim.keymap.set({ 'n', 'i' }, '<A-e>', function() ui.toggle_quick_menu() end, { desc = "show harpoon menu" })

-- switch it up!
vim.keymap.set({ 'n', 'i' }, '<A-h>', function() ui.nav_file(1) end, { desc = "harpoon 1 (the magic finger)" })
vim.keymap.set({ 'n', 'i' }, '<A-t>', function() ui.nav_file(2) end, { desc = "harpoon 2" })
vim.keymap.set({ 'n', 'i' }, '<A-n>', function() ui.nav_file(3) end, { desc = "harpoon 3" })
vim.keymap.set({ 'n', 'i' }, '<A-s>', function() ui.nav_file(4) end, { desc = "harpoon 4" })
vim.keymap.set({ 'n', 'i' }, '<A-m>', function() ui.nav_file(5) end, { desc = "harpoon 5" })
vim.keymap.set({ 'n', 'i' }, '<A-w>', function() ui.nav_file(6) end, { desc = "harpoon 6" })
vim.keymap.set({ 'n', 'i' }, '<A-v>', function() ui.nav_file(7) end, { desc = "harpoon 7" })
vim.keymap.set({ 'n', 'i' }, '<A-z>', function() ui.nav_file(8) end, { desc = "harpoon 8" })
