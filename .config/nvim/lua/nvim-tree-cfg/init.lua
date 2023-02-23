-- nvim-tree settings
require("nvim-tree").setup()
vim.keymap.set("n", "<leader><space>", function() require('nvim-tree.api').tree.toggle() end)
