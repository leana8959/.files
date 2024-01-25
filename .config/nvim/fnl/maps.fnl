(import-macros {: g! : map!} :hibiscus.vim)
(g! mapleader " ")
(g! maplocalleader " ")

(local map vim.keymap.set)
(local unmap vim.keymap.del)
(local autocmd vim.api.nvim_create_autocmd)

; Move
(map [:v] :J ":m '>+1<CR>gv=gv")
(map [:v] :K ":m '<-2<CR>gv=gv")

; Centered motions
(map [:n] :<C-d> "<C-d>zz")
(map [:n] :<C-u> "<C-u>zz")
(map [:n] :n "nzzzv")
(map [:n] :N "Nzzzv")
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
(map [:n]
     "<leader>w"
     (fn [] (set vim.o.wrap (not vim.o.wrap))))


; Replace selected token
(map [:v] :<leader>r "\"ry:%s/\\(<C-r>r\\)//g<Left><Left>")

(map [:n] :<leader>pv (fn [] (vim.cmd "Oil")))  ; Project View
(map [:n] :<leader>nf (fn [] (vim.cmd "enew"))) ; New File
(map [:n] :<leader>so (fn [] (vim.cmd "so %"))) ; Source buffer
(map [:c] :#capl "\\(.\\{-}\\)")              ; helpers in regex
(map [:c] :#capm "\\(.*\\)")
(map [:n] :<leader>+x (fn [] (vim.cmd "!chmod +x %")))  ; Permission
(map [:n] :<leader>-x (fn [] (vim.cmd "!chmod -x %")))
(map [:n] :<leader>hg (fn [] (vim.cmd "Inspect"))) ; Highlight Group

(map [:n] :Q "<nop>") ; *do not* repeat the last recorded register [count] times.


; Diagnostics
(map [:n] :<leader>e vim.diagnostic.open_float)
(map [:n] :<leader>pe vim.diagnostic.goto_prev)
(map [:n] :<leader>ne vim.diagnostic.goto_next)

; Leave terminal
(map [:t] :<Leader><ESC> "<C-\\><C-n>")

; Resize window using shift + arrow keys
; Credit: github.com/GrizzlT
(map [:n] :<S-Up> "<cmd>resize +2<cr>")
(map [:n] :<S-Down> "<cmd>resize -2<cr>")
(map [:n] :<S-Left> "<cmd>vertical resize -2<cr>")
(map [:n] :<S-Right> "<cmd>vertical resize +2<cr>")


;;;;;;;;;;;
; Plugins ;
;;;;;;;;;;;

; Tabular
(map [:n] :<leader>ta (fn [] (vim.cmd "Tabularize /=")))
(map [:n] :<leader>tc (fn [] (vim.cmd "Tabularize /:")))
(map [:n] :<leader>tC (fn [] (vim.cmd "Tabularize trailing_c_comments")))

; Twilight
(map [:n] :<leader>tw (fn [] (vim.cmd "Twilight")))

; Gitsigns
(map [:n] "<leader>gl"
  (fn []
    vim.cmd "Gitsigns toggle_numhl"
    vim.cmd "Gitsigns toggle_signs"))

; Fugitive
(map [:n] :<leader>gP (fn [] (vim.cmd "G push")))
(map [:n] :<leader>gp (fn [] (vim.cmd "G pull")))

(map [:n] :<leader><space> ":Git<CR>5<Down>")
(map [:n] :<leader>gu ":diffget //2<CR>")
(map [:n] :<leader>gh ":diffget //3<CR>")

(autocmd "FileType"
  { "pattern" "fugitive"
    "callback"
      (fn [] (map [:n] :<leader><space> ":q<CR>" {:buffer true}))})

(map [:n] "<leader>gb" ":Git blame<CR>")

(autocmd "FileType"
  { "pattern" "fugitiveblame"
    "callback"
      (fn [] (map [:n] "<leader>gb" ":q<CR>" {:buffer true}))})

; NoNeckPain
(map [:n] "<leader>z" ":NoNeckPain<CR>")

; Todo-Comments
(map [:n] "<leader>td" (fn [] (vim.cmd "TodoTelescope")))

; Undotree
(map [:n] "<leader>u"
  (fn []
    vim.cmd "UndotreeToggle"
    vim.cmd "UndotreeFocus"))

; color-picker
(map [:n] "<C-c>" (fn [] (vim.cmd "CccPick")) {:silent true})
