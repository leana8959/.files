(import-macros {: g! : map! : exec!} :hibiscus.vim)
(g! mapleader " ")
(g! maplocalleader " ")

(local map vim.keymap.set)
(local unmap vim.keymap.del)
(local autocmd vim.api.nvim_create_autocmd)

; Move
(map [:v] :J ":m '>+1<CR>gv=gv")
(map [:v] :K ":m '<-2<CR>gv=gv")

; Centered motions
(map [:n] :<C-d> :<C-d>zz)
(map [:n] :<C-u> :<C-u>zz)
(map [:n] :n :nzzzv)
(map [:n] :N :Nzzzv)
(map [:n] :J "mzJ`z")

; Better clipboard
(map [:n :x :v] :<leader>d "\"_d")
(map [:n :x :v] :<leader>c "\"_dc")
(map [:n :x :v] :<leader>p "\"_dP")
(map [:n :x :v] :<leader>y "\"+y")

; Linewrap jk
; Only use gj et al. when needed
(map! [:n :expr] :k "v:count == 0 ? 'gk' : 'k'")
(map! [:n :expr] :j "v:count == 0 ? 'gj' : 'j'")
(map [:n] :<leader>w #(set vim.o.wrap (not vim.o.wrap)))

; Replace selected token
(map [:v] :<leader>r "\"ry:%s/\\(<C-r>r\\)//g<Left><Left>")


; Project View
(map [:n] :<leader>pv ":Oil<CR>")

; New File
(map [:n] :<leader>nf ":enew<CR>")

; Source buffer
(map [:n] :<leader>so ":so %<CR>")

; helpers in regex
(map [:c] "#capl" "\\(.\\{-}\\)")
(map [:c] "#capm" "\\(.*\\)")
(map [:n] :<leader>+x ":!chmod +x %<CR>")

; Permission
(map [:n] :<leader>+x ":!chmod +x %<CR>")
(map [:n] :<leader>-x ":!chmod -x %<CR>")

; Highlight Group
(map [:n] :<leader>hg :Inspect<CR>)

; *do not* repeat the last recorded register [count] times.
(map [:n] :Q :<nop>)

; Diagnostics
(map [:n] :<leader>e vim.diagnostic.open_float)
(map [:n] :<leader>pe vim.diagnostic.goto_prev)
(map [:n] :<leader>ne vim.diagnostic.goto_next)

; Leave terminal
(map [:t] :<Leader><ESC> "<C-\\><C-n>")

; Resize window using shift + arrow keys
; Credit: github.com/GrizzlT
(map [:n] :<S-Up> ":resize +2<CR>")
(map [:n] :<S-Down> ":resize -2<CR>")
(map [:n] :<S-Left> ":vertical resize -2<CR>")
(map [:n] :<S-Right> ":vertical resize +2<CR>")

;;;;;;;;;;;
; Plugins ;
;;;;;;;;;;;

; Tabular
(map [:n] :<leader>ta ":Tabularize /= <CR>")
(map [:n] :<leader>tc ":Tabularize /: <CR>")
(map [:n] :<leader>tC ":Tabularize trailing_c_comments <CR>")

; Twilight
(map [:n] :<leader>tw ":Twilight<CR>")

; Fugitive
(map [:n] :<leader>gP ":G push<CR>")
(map [:n] :<leader>gp ":G pull<CR>")

(map [:n] :<leader><space> ":Git<CR>5<Down>")
(map [:n] :<leader>gu ":diffget //2<CR>")
(map [:n] :<leader>gh ":diffget //3<CR>")

(autocmd :FileType {:pattern :fugitive
                    :callback #(map [:n] :<leader><space> ":q<CR>"
                                    {:buffer true})})

(map [:n] :<leader>gb ":Git blame<CR>")

(autocmd :FileType
         {:pattern :fugitiveblame
          :callback #(map [:n] :<leader>gb ":q<CR>" {:buffer true})})

; NoNeckPain
(map [:n] :<leader>z ":NoNeckPain<CR>")

; Todo-Comments
(map [:n] :<leader>td ":TodoTelescope<CR>")

; Undotree
(map [:n] :<leader>u #(exec! [:UndotreeToggle :UndotreeFocus]))

; color-picker
(map [:n] :<C-c> ":CccPick<CR>" {:silent true})
