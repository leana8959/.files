local M = {}

local api = vim.api
local fn = vim.fn

api.nvim_set_hl(0, "WinBar", { fg = "#dedede" })
api.nvim_set_hl(0, "WinBarPath", { bg = "#dedede" })
api.nvim_set_hl(0, "WinBarModified", { bg = "#dedede", bold = true })

function M.eval()
    local buffer = api.nvim_win_get_buf(0)
    local bufname = fn.bufname(buffer)
    local modified = ""
    local readonly = ""

    if vim.bo[buffer].readonly then
        readonly = "[RO] "
    end

    if vim.bo[buffer].modified then
        modified = "[+] "
    end

    bufname = fn.fnamemodify(bufname, ":p:~")

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
