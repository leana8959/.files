(import-macros {: nil?} :hibiscus.core)
(local {: require-then} (require :helpers))

(local cmp (require :cmp))
(local ls (require :luasnip))

;; Nodes
(local {:snippet s
        :snippet_node sn
        :text_node t
        :insert_node i
        :function_node f
        :choice_node c
        :dynamic_node d
        :restore_node r} ls)

;; linebreak
(macro cr []
  `(t ["" ""]))

;; Extras
(local {: l : rep : p : m : n : dl} (require :luasnip.extras))
(local {: fmt : fmta} (require :luasnip.extras.fmt))

(local types (require :luasnip.util.types))
(local conds (require :luasnip.extras.conditions))
(local conds_expand (require :luasnip.extras.conditions.expand))

(fn has-words-before []
  (local unpack (or unpack table.unpack))
  (local [line col] (vim.api.nvim_win_get_cursor 0))
  (and (not= col 0)
       (nil? (let [l (. (vim.api.nvim_buf_get_lines 0 (- line 1) line true) 1)]
               (: (: l :sub col col) :match "%s")))))

;;;;;;;;;;;;;;;
; Lazy loader ;
;;;;;;;;;;;;;;;
(require-then :luasnip.loaders.from_vscode
              #($.lazy_load {:paths [:./snippets]}))

;;;;;;;;
; Init ;
;;;;;;;;
(ls.setup {:update_events [:TextChanged :TextChangedI]})

;;;;;;;;;
; Typst ;
;;;;;;;;;
(fn show-date-typst-entry []
  (os.date "(year: %Y, month: %m, day: %d, hour: %H, minute: %M, second: %S)"))

;; fnlfmt: skip
(ls.add_snippets "typst"
  [(s "entry"
    [ (t "#entry(")
      (f show-date-typst-entry)
      (t [")[" ""])
      (i 0)
      (t ["" "]"])])])

;; fnlfmt: skip
(ls.add_snippets "all"
  (let
    [ left #(vim.bo.commentstring:gsub "%s*%%s.*" "")
      right
        #(let [t (vim.bo.commentstring:gsub ".*%%s%s*" "")]
          (if (= t "") (left) t))
      horizon
        (fn [[[w]] & _]
          (local [left right] [(left) (right)])
          (local chr (left:sub -1))
          (local len (vim.fn.strdisplaywidth w))

          (var acc left)
          (for [_ (left:len) (+ len (right:len) 1)]
            (set acc (.. acc chr)))

          (.. acc right))]
    [(s "banner"
      [ (f horizon [ 1 ]) (cr)
        (f left) (t " ") (i 1) (t " ") (f right) (cr)
        (f horizon [ 1 ])])]))

;;;;;;;;;;
; Ledger ;
;;;;;;;;;;

;; fnlfmt: skip
(let
  [ show-date-ledger-entry #(os.date "%Y-%m-%d")
    id (fn [[[w]] & _] w)]
  ;; shortcuts
  (ls.add_snippets "ledger"
    [(s "lessive"
      [ (f show-date-ledger-entry) (t "") (t "Lessive (CROUS)") (cr)
        (t "\texpenses                         3,00 EUR")       (cr)
        (t "\tassets:compte_courant           -3,00 EUR")       (cr)])
     (s "sechoir"
      [ (f show-date-ledger-entry) (t "") (t "Sechoir (CROUS)") (cr)
        (t "\texpenses                         1,50 EUR")       (cr)
        (t "\tassets:compte_courant           -1,50 EUR")       (cr)])])
  ;; generic snippets
  (ls.add_snippets "ledger"
      [ (s "entry" [
            (f show-date-ledger-entry) (t " ") (i 1)                           (cr)
            (t "\texpenses:") (i 2) (t "            ") (i 3) (t " EUR")        (cr)
            (t "\tassets:compte_courant           -")  (f id [ 3 ]) (t " EUR") (cr)
        ])
        (s "date-entry" [
            (i 1) (t " ") (i 2)                                                (cr)
            (t "\texpenses:") (i 3) (t "            ") (i 4) (t " EUR")        (cr)
            (t "\tassets:compte_courant           -")  (f id [ 4 ]) (t " EUR") (cr)])])
  )

;;;;;;;;;;;
; Haskell ;
;;;;;;;;;;;
(ls.add_snippets :haskell (. (require :haskell-snippets) :all) {:key :haskell})

;;;;;;;;;;;;;
; Setup CMP ;
;;;;;;;;;;;;;
(let [snippet {:expand #(ls.lsp_expand $.body)}
      myMapping {;; Next or jump
                 :<Tab> (cmp.mapping #(if (cmp.visible)
                                          (cmp.select_next_item)
                                          (ls.expand_or_locally_jumpable)
                                          (ls.expand_or_jump)
                                          (has-words-before)
                                          (cmp.complete)
                                          ($))
                                     [:i :s])
                 ;; Previous
                 :<S-Tab> (cmp.mapping #(if (cmp.visible)
                                            (cmp.select_prev_item)
                                            (ls.jumpable -1)
                                            (ls.jump -1)
                                            ($))
                                       [:i :s])
                 ;; Force jump
                 :<A-Tab> (cmp.mapping #(if (ls.expand_or_locally_jumpable)
                                            (ls.expand_or_jump)
                                            ($))
                                       [:i :s])
                 ;; Confirm
                 :<CR> (cmp.mapping #(if (cmp.visible)
                                         ((cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                                :select true}))
                                         ($))
                                    [:i :s])
                 ;; Confirm
                 :<S-CR> (cmp.mapping #(if (cmp.visible)
                                           ((cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                  :select true}))
                                           ($))
                                      [:i :s])}
      sources (let [{: Contains} (require :utils)
                    of-filetype (fn [fts] (Contains fts vim.bo.filetype))]
                [{:name :luasnip}
                 {:name :nvim_lsp}
                 {:name :buffer
                  :keyword_length 10
                  :option {:enable_in_context #(of-filetype [:tex
                                                             :markdown
                                                             :typst]
                                                            $)}}
                 {:name :spell
                  :keyword_length 10
                  :option {:keep_all_entries true
                           :enable_in_context #(of-filetype [:tex
                                                             :markdown
                                                             :typst]
                                                            $)}}])]
  (cmp.setup {: snippet
              :mapping (cmp.mapping.preset.insert myMapping)
              : sources}))
