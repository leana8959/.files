(local {: require-then} (require :helpers))

(require-then :harpoon #($.setup))

(let [ui (require :harpoon.ui)
      mark (require :harpoon.mark)
      map vim.keymap.set]
  ;; and and view
  (map [:n :i] :<A-c> #(mark.add_file))
  (map [:n :i] :<A-g> #(ui.toggle_quick_menu))
  ;; switch it up!
  (map [:n :i] :<A-h> #(ui.nav_file 1))
  (map [:n :i] :<A-t> #(ui.nav_file 2))
  (map [:n :i] :<A-n> #(ui.nav_file 3))
  (map [:n :i] :<A-s> #(ui.nav_file 4))
  (map [:n :i] :<A-m> #(ui.nav_file 5))
  (map [:n :i] :<A-w> #(ui.nav_file 6))
  (map [:n :i] :<A-v> #(ui.nav_file 7))
  (map [:n :i] :<A-z> #(ui.nav_file 8)))
