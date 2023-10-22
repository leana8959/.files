local M = {}

vim.api.nvim_set_hl(0, 'WinBarPath', { bg = '#dedede', })
vim.api.nvim_set_hl(0, 'WinBarModified', { bg = '#dedede', bold = true })

function M.eval()
    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and '[+]' or ''

    return "%="
        .. '%#WinBarModified#'
        .. modified
        .. '%*'
        .. '%#WinBarPath#'
        .. " "
        .. file_path
        -- .. '%*'
end

return M
