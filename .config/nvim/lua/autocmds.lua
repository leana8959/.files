local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

vim.filetype.add { extension = { typ = "typst" } }
vim.filetype.add { extension = { skel = "skel", sk = "skel" } }

autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

autocmd("Filetype", {
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
autocmd("BufEnter", {
    pattern  = "*Caddyfile*",
    callback = function()
        vim.opt_local.filetype      = "Caddy"
        vim.opt_local.commentstring = "# %s"
    end,
})

-- Update leading indent guide
-- source: https://github.com/thaerkh/vim-indentguides
autocmd("OptionSet", {
    pattern  = "shiftwidth",
    callback = function()
        if vim.o.expandtab then
            -- leadmultispace is shiftwidth agnostic
            local c = ""
            for _ = c:len(), vim.o.shiftwidth + 1, 1 do c = c .. " " end
            vim.opt.listchars:append { leadmultispace = c }
        end
    end,
})

-- Enable NoNeckPain
autocmd("UIEnter", { callback = function() vim.cmd "NoNeckPain" end })

-- Retab file with specified shiftwidth
usercmd("Retab", function(opts)
    local dst         = tonumber(opts.fargs[1])
    vim.opt.expandtab = false
    vim.cmd "%retab!"
    vim.opt.shiftwidth = dst
    vim.opt.tabstop    = dst
    vim.opt.expandtab  = true
    vim.cmd "%retab!"
end, { nargs = 1 })
