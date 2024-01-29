(local Rule (require :nvim-autopairs.rule))
(local cond (require :nvim-autopairs.conds))
(local npairs (require :nvim-autopairs))

(npairs.setup {:disable_filetype [:fennel :clojure :lisp :racket :scheme]})

(local cmp (require :cmp))
(local cmp-autopairs (require :nvim-autopairs.completion.cmp))

(cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))

(npairs.add_rules [(-> (Rule "$" "$" [:tex :typst])
                       (: :with_pair (cond.not_after_text "$"))
                       (: :with_pair (cond.not_before_text "$"))
                       (: :with_pair (cond.not_after_regex "%a"))
                       (: :with_pair (cond.not_before_regex "%a"))
                       (: :with_move cond.done))
                   (-> (Rule "```" "```" :typst)
                       (: :with_pair (cond.not_before_text "```"))
                       (: :with_cr cond.done))])

;; Move past commas and semicolons
;; credits: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#move-past-commas-and-semicolons
(each [_ punct (ipairs ["," ";"])]
  (npairs.add_rule (-> (Rule "" punct)
                       (: :with_move #(= $.char punct))
                       (: :with_pair #false)
                       (: :with_del #false)
                       (: :with_cr #false)
                       (: :use_key punct))))

