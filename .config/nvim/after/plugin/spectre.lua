local spectre = require "spectre"

vim.keymap.set("n", "<leader>ss", function() spectre.open() end, { desc = "search and replace" })
