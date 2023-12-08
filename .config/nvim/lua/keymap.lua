vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map            = vim.keymap.set
local unmap          = vim.keymap.del
local autocmd        = vim.api.nvim_create_autocmd

-- Move
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Centered motions
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Better clipboard
map({ "n", "x", "v" }, "<leader>d", '"_d')
map({ "n", "x", "v" }, "<leader>c", '"_dc')
map({ "n", "x", "v" }, "<leader>p", '"_dP')
map({ "n", "x", "v" }, "<leader>y", '"+y')

-- Linewrap jk
-- Only use gj et al. when needed
local function linewrap_jk_on()
    map("n", "j", "gj")
    map("n", "k", "gk")
    map("n", "<Down>", "g<Down>")
    map("n", "<Up>", "g<Up>")
end
local function linewrap_jk_off()
    unmap("n", "j")
    unmap("n", "k")
    unmap("n", "<Down>")
    unmap("n", "<Up>")
end
map("n", "<leader>w", function()
    vim.o.wrap = not vim.o.wrap
    if vim.o.wrap then linewrap_jk_on() else linewrap_jk_off() end
end)

-- Replace selected token
map("v", "<leader>r", [["ry:%s/\(<C-r>r\)//g<Left><Left>]])

map("n", "<leader>pv", function() vim.cmd "Oil" end)         -- Project View
map("n", "<leader>nf", function() vim.cmd "enew" end)        -- New File
map("n", "<leader>so", function() vim.cmd "so %" end)        -- Source buffer
map("c", "#capl", [[\(.\{-}\)]])                             -- helpers in regex
map("c", "#capm", [[\(.*\)]])
map("n", "<leader>+x", function() vim.cmd "!chmod +x %" end) -- Permission
map("n", "<leader>-x", function() vim.cmd "!chmod -x %" end)
map("n", "<leader>hg", function() vim.cmd "Inspect" end)     -- Highlight Group
map("n", "Q", "<nop>")                                       -- *do not* repeat the last recorded register [count] times.

-- Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "<leader>pe", vim.diagnostic.goto_prev)
map("n", "<leader>ne", vim.diagnostic.goto_next)

map("t", "<Leader><ESC>", "<C-\\><C-n>")

-------------
-- Plugins --
-------------

-- Tabular
map("n", "<leader>ta", function() vim.cmd "Tabularize /=" end)
map("n", "<leader>tc", function() vim.cmd "Tabularize /:" end)
map("n", "<leader>tC", function() vim.cmd "Tabularize trailing_c_comments" end)

-- Fugitive
map("n", "<leader>gP", function() vim.cmd "G push" end)
map("n", "<leader>gp", function() vim.cmd "G pull" end)

-- Twilight
map("n", "<leader>tw", function() vim.cmd "Twilight" end)

-- Gitsigns
map("n", "<leader>gl",
    function()
        vim.cmd "Gitsigns toggle_numhl"
        vim.cmd "Gitsigns toggle_signs"
    end
)

-- Fugitive
map("n", "<leader><space>", ":Git<CR>5<Down>")
map("n", "<leader>gu", ":diffget //2<CR>")
map("n", "<leader>gh", ":diffget //3<CR>")
autocmd("FileType", {
    pattern = "fugitive",
    callback = function() map("n", "<leader><space>", ":q<CR>", { buffer = true }) end,
})
map("n", "<leader>gb", ":Git blame<CR>")
autocmd("FileType", {
    pattern = "fugitiveblame",
    callback = function() map("n", "<leader>gb", ":q<CR>", { buffer = true }) end,
})

-- NoNeckPain
map("n", "<leader>z", ":NoNeckPain<CR>")

-- Todo-Comments
map("n", "<leader>td", function() vim.cmd "TodoTelescope" end)

-- Undotree
map("n", "<leader>u", function()
    vim.cmd "UndotreeToggle"
    vim.cmd "UndotreeFocus"
end)
autocmd("FileType", {
    pattern = "undotree",
    callback = function() map("n", "<leader>gb", ":q<CR>", { buffer = true }) end,
})

-- color-picker
map("n", "<C-c>", function() vim.cmd "CccPick" end, { silent = true })
