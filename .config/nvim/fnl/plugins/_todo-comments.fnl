(local {: require-then} (require :helpers))

(let [config {:keywords {:FIX {:alt [:FIXME :BUG :FIXIT :ISSUE]
                               :color :error
                               :icon " "}
                         :HACK {:alt [:DEBUG] :color :warning :icon "!"}
                         :NOTE {:alt [:INFO] :color :hint :icon "·"}
                         :Q {:color :warning :icon "?"}
                         :TEST {:alt [:TESTING :PASSED :FAILED]
                                :color :test
                                :icon :T}
                         :TODO {:color :info :icon " "}
                         :WARN {:alt [:WARNING :XXX] :color :warning :icon "!"}}}]
  (require-then :todo-comments #($.setup config)))
