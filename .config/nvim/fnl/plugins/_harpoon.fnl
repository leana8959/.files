(import-macros {: map!} :hibiscus.vim)
(import-macros {: req-do!} :macros)

(req-do! :harpoon #($.setup))

(let [ui (require :harpoon.ui)
      mark (require :harpoon.mark)]
  ;; and and view
  (map! [:ni] :<A-c> #(mark.add_file))
  (map! [:ni] :<A-g> #(ui.toggle_quick_menu))
  ;; switch it up!
  (map! [:ni] :<A-h> #(ui.nav_file 1))
  (map! [:ni] :<A-t> #(ui.nav_file 2))
  (map! [:ni] :<A-n> #(ui.nav_file 3))
  (map! [:ni] :<A-s> #(ui.nav_file 4))
  (map! [:ni] :<A-m> #(ui.nav_file 5))
  (map! [:ni] :<A-w> #(ui.nav_file 6))
  (map! [:ni] :<A-v> #(ui.nav_file 7))
  (map! [:ni] :<A-z> #(ui.nav_file 8)))
