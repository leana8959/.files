(local M {})
(local api vim.api)

(api.nvim_set_hl 0 :WinBar {:fg "#dedede"})
(api.nvim_set_hl 0 :WinBarPath {:bg "#dedede"})
(api.nvim_set_hl 0 :WinBarModified {:bg "#dedede" :bold true})

(fn M.eval []
  (let [buffer (api.nvim_win_get_buf 0)]
    (var bufname (vim.fn.bufname buffer))
    (var modified "")
    (var readonly "")
    (when (. (. vim.bo buffer) :readonly) (set readonly "[RO] "))
    (when (. (. vim.bo buffer) :modified) (set modified "[+] "))
    (set bufname (vim.fn.fnamemodify bufname ":p:~"))
    (.. "%=" "%#WinBarModified#" readonly modified "%*" "%#WinBarPath#" bufname
        "%*")))

M
