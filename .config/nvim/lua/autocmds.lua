local api = vim.api
local opt = vim.opt
local map = vim.keymap.set

vim.filetype.add { extension = { typ = "typst" } }
vim.filetype.add { extension = { skel = "skel", sk = "skel" } }

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

opt.listchars = {
    tab   = " ",
    trail = "␣",
}
opt.list = true

api.nvim_create_autocmd("FileType", {
    pattern  = { "markdown", "tex", "typst" },
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop    = 4
        vim.opt_local.wrap       = true
    end,
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
