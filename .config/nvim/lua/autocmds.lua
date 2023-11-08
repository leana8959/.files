local api = vim.api
local map = vim.keymap.set

vim.filetype.add { extension = { typ = "typst" } }
vim.filetype.add { extension = { skel = "skel", sk = "skel" } }

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function() vim.opt_local.iskeyword:append "&" end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "fish",
    callback = function() vim.opt_local.iskeyword:append "$" end,
})

api.nvim_create_autocmd("Filetype", {
    pattern  = "skel",
    callback = function()
        vim.opt_local.commentstring = "(* %s *)"
        map("n", "<leader>f",
            function()
                vim.cmd ":w"
                vim.cmd [[silent exec "!necroprint % -o %"]]
                vim.cmd ":e"
            end,
            { buffer = true })
    end,
})

-- Using `sudoedit` would create gibberish extension names,
-- detection using extension would hence not work.
api.nvim_create_autocmd("BufEnter", {
    pattern  = "*Caddyfile*",
    callback = function()
        vim.opt_local.filetype      = "Caddy"
        vim.opt_local.commentstring = "# %s"
    end,
})

-- Update leading indent guide
-- source: https://github.com/thaerkh/vim-indentguides
api.nvim_create_autocmd("OptionSet", {
    pattern  = "shiftwidth",
    callback = function()
        if vim.o.expandtab then
            local c = ""
            for _ = c:len(), vim.o.shiftwidth + 1, 1 do c = c .. " " end
            vim.opt.listchars:append { leadmultispace = c }
        end
    end,
})
