local M = {}

vim.api.nvim_set_hl(0, "WinBarPath", { bg = "#dedede" })
vim.api.nvim_set_hl(0, "WinBarModified", { bg = "#dedede", bold = true })

function M.eval()
    local buffer = vim.api.nvim_win_get_buf(0)
    local bufname = vim.fn.bufname(buffer)
    local modified = ""
    local readonly = ""

    if vim.bo[buffer].readonly then
        readonly = "[RO] "
    end

    if vim.bo[buffer].modified then
        modified = "[+] "
    end

    return "%="
        .. "%#WinBarModified#"
        .. readonly
        .. modified
        .. "%*"
        .. "%#WinBarPath#"
        .. bufname
        .. "%*"
end

return M
