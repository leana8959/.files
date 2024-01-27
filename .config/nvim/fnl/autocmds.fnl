(local map vim.keymap.set)
(local autocmd vim.api.nvim_create_autocmd)
(local usercmd vim.api.nvim_create_user_command)

(vim.filetype.add {:extension {:typ :typst}})
(vim.filetype.add {:extension {:skel :skel :sk :skel}})
(vim.filetype.add {:extension {:mlw :why3}})

(autocmd :TextYankPost {:callback (fn [] (vim.highlight.on_yank))})

(autocmd :FileType
         {:pattern [:markdown :tex :typst]
          :callback (fn []
                      (tset vim.opt_local :shiftwidth 2)
                      (tset vim.opt_local :tabstop 2)
                      (tset vim.opt_local :textwidth 2))})

(autocmd :FileType {:pattern :skel
                    :callback (fn []
                                (tset vim.opt_local :commentstring "(* %s *)")
                                (map :n :<leader>f
                                     (fn []
                                       (vim.cmd ":w")
                                       (vim.cmd "silent exec \"!necroprint % -o %\"")
                                       (vim.cmd ":e"))
                                     {:buffer true}))})

(autocmd :FileType {:pattern :fennel
                    :callback (fn []
                                (tset vim.opt_local :list false)
                                (map :n :<leader>f
                                     (fn []
                                       (vim.cmd ":w")
                                       (vim.cmd "silent exec \"!fnlfmt --fix %\"")
                                       (vim.cmd ":e"))
                                     {:buffer true}))})

(autocmd :FileType
         {:pattern :why3
          :callback (fn []
                      (tset vim.opt_local :commentstring "(* %s *)")
                      (tset vim.opt_local :shiftwidth 2)
                      (tset vim.opt_local :tabstop 2)
                      (tset vim.opt_local :expandtab true))})

; Using `sudoedit` would create gibberish extension names,
; detection using extension would hence not work.
(autocmd :BufEnter
         {:pattern :*Caddyfile
          :callback (fn []
                      (tset vim.opt_local :filetype :Caddy)
                      (tset vim.opt_local :commentstring "# %s"))})

(autocmd :OptionSet
         {:pattern :shiftwidth
          :callback (fn []
                      (when vim.o.expandtab
                        (var c "")
                        (for [_ (c:len) (+ vim.o.shiftwidth 1)]
                          (set c (.. c " ")))
                        (vim.opt.listchars:append {:leadmultispace c})))})

(usercmd :Retab
         (fn [opts]
           (if (= (length opts.fargs) 2)
               (let [src (tonumber (. opts.fargs 1))
                     dst (tonumber (. opts.fargs 2))]
                 (tset vim.opt :shiftwidth src)
                 (tset vim.opt :tabstop src)
                 (tset vim.opt :expandtab false)
                 (vim.cmd "%retab!")
                 (tset vim.opt :shiftwidth dst)
                 (tset vim.opt :tabstop dst)
                 (tset vim.opt :expandtab true)
                 (vim.cmd "%retab!"))
               (print "should have exactly two argument: [src] and [dst]")))
         {:nargs "+"})
