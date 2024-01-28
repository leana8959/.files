(import-macros {: map!} :hibiscus.vim)
(import-macros {: req-do!} :macros)

(let [config {:on_attach (fn [bufno]
                           (let [gs package.loaded.gitsigns]
                             ;; Navigation
                             (map! [n :buffer] :<leader>hj gs.next_hunk)
                             (map! [n :buffer] :<leader>hk gs.prev_hunk)
                             ;; Actions
                             (map! [n :buffer] :<leader>hs gs.stage_hunk)
                             (map! [n :buffer] :<leader>hu gs.undo_stage_hunk)
                             (map! [n :buffer] :<leader>hr gs.reset_hunk)
                             (map! [v :buffer] :<leader>hs
                                   #(gs.stage_hunk [(vim.fn.line ".")
                                                    (vim.fn.line :v)]))
                             (map! [v :buffer] :<leader>hr
                                   #(gs.reset_hunk [(vim.fn.line ".")
                                                    (vim.fn.line :v)]))
                             (map! [n :buffer] :<leader>hS gs.stage_buffer)
                             (map! [n :buffer] :<leader>hR gs.reset_buffer)
                             (map! [n :buffer] :<leader>hp gs.preview_hunk)
                             (map! [n :buffer] :<leader>hb
                                   #(gs.blame_line {:full true}))
                             (map! [n :buffer] :<leader>tb
                                   gs.toggle_current_line_blame)
                             (map! [n :buffer] :<leader>hd gs.diffthis)
                             (map! [n :buffer] :<leader>hD #(gs.diffthis "~"))
                             (map! [n :buffer] :<leader>pd gs.toggle_deleted)
                             ;; Text object
                             (map! [ox] :ih ":<C-U>Gitsigns select_hunk<CR>")))}]
  (req-do! :gitsigns #($.setup config)))
