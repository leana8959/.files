vim.keymap.set('n', "<leader>u", function() vim.cmd("UndotreeToggle") end,
    { desc = "Toggle undotree view", noremap = true })
