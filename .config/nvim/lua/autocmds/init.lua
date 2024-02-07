local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

vim.filetype.add { extension = { typ = "typst" } }
vim.filetype.add { extension = { skel = "skel", sk = "skel" } }
vim.filetype.add { extension = { mlw = "why3" } }

autocmd("TextYankPost", { callback = vim.highlight.on_yank })

autocmd("FileType", {
    pattern = { "markdown", "tex", "typst" },
    callback =
        function()
            vim.opt_local["shiftwidth"] = 2
            vim.opt_local["tabstop"] = 2
            vim.opt_local["textwidth"] = 80
        end,
})

autocmd("FileType", {
    pattern = "skel",
    callback = function()
        vim.opt_local["commentstring"] = "(* %s *)"
        vim.keymap.set({ "n" }, "<leader>f", function()
            vim.cmd "w "
            vim.cmd "silent exec '!necroprint % -o %'"
            vim.cmd "e "
        end, { buffer = true, silent = true })
    end,
})

autocmd("FileType", {
    pattern = "fennel",
    callback = function()
        vim.opt_local["list"] = false
        return vim.keymap.set({ "n" }, "<leader>f", function()
            vim.cmd "w "
            vim.cmd "silent exec '!fnlfmt --fix %'"
            vim.cmd "e "
        end, { buffer = true, silent = true })
    end,
})

autocmd("FileType", {
    pattern = "why3",
    callback = function()
        vim.opt_local["commentstring"] = "(* %s *)"
        vim.opt_local["shiftwidth"] = 2
        vim.opt_local["tabstop"] = 2
        vim.opt_local["expandtab"] = true
    end,
})

autocmd("BufEnter", {
    pattern = "*Caddyfile",
    callback = function()
        vim.opt_local["filetype"] = "Caddy"
        vim.opt_local["commentstring"] = "# %s"
    end,
})

autocmd("OptionSet", {
    pattern = "shiftwidth",
    callback = function()
        if vim.o.expandtab then
            local c = ""
            for _ = c:len(), vim.o.shiftwidth + 1 do
                c = c .. " "
            end
            return vim.opt.lcs:append("leadmultispace:" .. c)
        else
            return nil
        end
    end,
})

usercmd("Retab", function(opts)
    if (#opts.fargs ~= 2) then
        return print "should have exactly two argument: [src] and [dst]"
    end
    local src = tonumber(opts.fargs[1])
    local dst = tonumber(opts.fargs[2])
    vim.opt["shiftwidth"] = src
    vim.opt["tabstop"] = src
    vim.opt["expandtab"] = false
    vim.cmd "%retab! "
    vim.opt["shiftwidth"] = dst
    vim.opt["tabstop"] = dst
    vim.opt["expandtab"] = true
    vim.cmd "%retab! "
end, { nargs = "+" })
