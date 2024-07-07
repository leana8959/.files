local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("TextYankPost", { callback = vim.highlight.on_yank })

vim.filetype.add {
    extension = {
        [".*Caddyfile"] = "caddyfile",
        hledger = "ledger",
        mlw = "why3",
        pro = "projet",
        sk = "skel",
        skel = "skel",
        typ = "typst",
    },
}

autocmd("BufEnter", {
    pattern = "justfile",
    callback = function() vim.bo.filetype = "make" end,
})

autocmd("FileType", {
    pattern = "gitcommit",
    callback = function() vim.bo.textwidth = 72 end,
})

autocmd("FileType", {
    pattern = "markdown",
    callback = function() vim.cmd("setlocal sw=2 ts=2 tw=100 colorcolumn=100 spell spelllang=en,fr") end,
})

autocmd("FileType", {
    pattern = { "tex", "typst" },
    callback = function() vim.cmd("setlocal sw=2 ts=2 tw=80 colorcolumn=80 spell spelllang=fr,en") end,
})

autocmd("FileType", {
    pattern = "ledger",
    callback = function()
        vim.cmd("setlocal varsofttabstop=4,30,8,4 spell spelllang=fr")
        -- TODO: remove this when PR is merged
        vim.bo.commentstring = "; %s"
    end,
})

autocmd("FileType", {
    pattern = "asm",
    callback = function() vim.bo.commentstring = "# %s" end,
})

-- "Projet" language taught at ISTIC
autocmd("FileType", {
    pattern = "projet",
    callback = function() vim.bo.commentstring = "{ %s }" end,
})

autocmd("FileType", {
    pattern = "skel",
    callback = function()
        vim.bo.commentstring = "(* %s *)"
        vim.keymap.set("n", "<leader>f", function()
            vim.cmd("w")
            vim.cmd("silent exec '!necroprint % -o %'")
            vim.cmd("e")
        end, { buffer = true, silent = true })
    end,
})

autocmd("FileType", {
    pattern = "why3",
    callback = function()
        vim.bo.commentstring = "(* %s *)"
        vim.cmd([[setlocal sw=2 ts=2 et]])
    end,
})

autocmd("FileType", {
    pattern = { "nix", "haskell", "ocaml", "skel" },
    callback = function() vim.cmd([[let b:match_words = '\<let\>:\<in\>']]) end,
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

autocmd("OptionSet", {
    pattern = "textwidth",
    callback = function() vim.wo.colorcolumn = tostring(vim.bo.textwidth) end,
})

usercmd("Retab", function(opts)
    if #opts.fargs ~= 2 then return print("should have exactly two argument: [src] and [dst]") end
    local src = tonumber(opts.fargs[1])
    local dst = tonumber(opts.fargs[2])
    if src == nil then print("first argument [src] is not a valid number") end
    if dst == nil then print("second argument [dst] is not a valid number") end

    vim.bo.shiftwidth = src
    vim.bo.tabstop = src
    vim.bo.expandtab = false
    vim.cmd("%retab!")
    vim.bo.shiftwidth = dst
    vim.bo.tabstop = dst
    vim.bo.expandtab = true
    vim.cmd("%retab!")
end, { nargs = "+" })
