(local {: require-then} (require :helpers))

(let [config {:width 75 :buffers {:right {:enabled false}}}]
  (require-then :no-neck-pain #($.setup config)))
