(import-macros {: req-do!} :macros)

(let [config {:width 75 :buffers {:right {:enabled false}}}]
  (req-do! :no-neck-pain #($.setup config)))
