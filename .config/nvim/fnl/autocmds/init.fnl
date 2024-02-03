(import-macros {: map! : set! : setlocal! : set+ : exec!} :hibiscus.vim)

(local autocmd vim.api.nvim_create_autocmd)
(local usercmd vim.api.nvim_create_user_command)

(vim.filetype.add {:extension {:typ :typst}})
(vim.filetype.add {:extension {:skel :skel :sk :skel}})
(vim.filetype.add {:extension {:mlw :why3}})

(autocmd :TextYankPost {:callback #(vim.highlight.on_yank)})

(autocmd :FileType {:pattern [:markdown :tex :typst]
                    :callback (fn []
                                (setlocal! :shiftwidth 2)
                                (setlocal! :tabstop 2)
                                (setlocal! :textwidth 80))})

(autocmd :FileType {:pattern :skel
                    :callback (fn []
                                (setlocal! :commentstring "(* %s *)")
                                (map! [:n :buffer] :<leader>f
                                      #(exec! [w]
                                              [silent
                                               exec
                                               "!necroprint % -o %"]
                                              [e])))})

(autocmd :FileType {:pattern :fennel
                    :callback (fn []
                                (setlocal! :list false)
                                (map! [:n :buffer] :<leader>f
                                      #(exec! [w]
                                              [silent exec "!fnlfmt --fix %"]
                                              [e])))})

(autocmd :FileType
         {:pattern :why3
          :callback (fn []
                      (setlocal! :commentstring "(* %s *)")
                      (setlocal! :shiftwidth 2)
                      (setlocal! :tabstop 2)
                      (setlocal! :expandtab true))})

; Using `sudoedit` would create gibberish extension names,
; detection using extension would hence not work.
(autocmd :BufEnter
         {:pattern :*Caddyfile
          :callback (fn []
                      (setlocal! :filetype :Caddy)
                      (setlocal! :commentstring "# %s"))})

(autocmd :OptionSet
         {:pattern :shiftwidth
          :callback (fn []
                      (when vim.o.expandtab
                        (var c "")
                        (for [_ (c:len) (+ vim.o.shiftwidth 1)]
                          (set c (.. c " ")))
                        (set+ lcs (.. "leadmultispace:" c))))})

(usercmd :Retab
         (fn [opts]
           (if (= (length opts.fargs) 2)
               (let [src (tonumber (. opts.fargs 1))
                     dst (tonumber (. opts.fargs 2))]
                 (set! :shiftwidth src)
                 (set! :tabstop src)
                 (set! :expandtab false)
                 (exec! [%retab!])
                 (set! :shiftwidth dst)
                 (set! :tabstop dst)
                 (set! :expandtab true)
                 (exec! [%retab!]))
               (print "should have exactly two argument: [src] and [dst]")))
         {:nargs "+"})
