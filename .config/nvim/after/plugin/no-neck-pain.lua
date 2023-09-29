require "no-neck-pain".setup {
    width = 75,
    buffers = {
        right = { enabled = false, }
    }
}

vim.keymap.set("n", "<leader>z", ":NoNeckPain<CR>", { desc = "Center this shit plz" })
