local opt = vim.opt
local api = vim.api
local map = vim.keymap.set

opt.hlsearch = false
opt.incsearch = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4

-- wrapping makes the editor EXTREMELY slow, turn it off by default
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.filetype = "on"

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.termguicolors = true
opt.mouse = "a"

opt.ignorecase = true
opt.smartcase = true
opt.autoindent = true
opt.smartindent = true

opt.scrolloff = 3

opt.colorcolumn = "80"

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

opt.listchars = {
    tab = " ",
    trail = "␣",
}
opt.list = true

api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex", "typst" },
    callback = function()
        vim.cmd("setlocal wrap")
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "rust" },
    callback = function() vim.cmd("setlocal iskeyword+=&") end,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "fish" },
    callback = function() vim.cmd("setlocal iskeyword+=$") end,
})

-- Using `sudoedit` would create gibberish extension names,
-- detection using extension would hence not work.
api.nvim_create_autocmd("BufEnter", {
    pattern  = { "*Caddyfile*" },
    callback = function()
        vim.opt_local.filetype = "Caddy"
        vim.bo.commentstring   = "# %s"
    end,
})

api.nvim_create_autocmd("Filetype", {
    pattern  = { "skel" },
    callback = function()
        vim.bo.commentstring = "(* %s *)"
        map('n', '<leader>f',
            function()
                vim.cmd(":w")
                vim.cmd([[silent exec "!necroprint % -o %"]])
                vim.cmd(":e")
            end,
            { buffer = true })
    end,
})

vim.filetype.add({ extension = { typ = "typst" } })
vim.filetype.add({ extension = { skel = "skel", sk = "skel" } })
