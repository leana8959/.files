(local {: require-then} (require :helpers))

(let [config {:auto_install true
              :disable (fn [lang buf]
                         (local max-filesize (* 100 1024))
                         (local (ok stats)
                                (pcall vim.loop.fs_stat
                                       (vim.api.nvim_buf_get_name buf)))
                         (when (and (and ok stats) (> stats.size max-filesize))
                           true))
              :ensure_installed {}
              :highlight {:enable true}
              :sync_install false
              :textobjects {:select {:enable true
                                     :include_surrounding_whitespace true
                                     :keymaps {:ac "@class.outer"
                                               :af "@function.outer"
                                               :ic "@class.inner"
                                               :if "@function.inner"}
                                     :lookahead true
                                     :selection_modes {"@class.outer" :<c-v>
                                                       "@function.outer" :V
                                                       "@parameter.outer" :v}}
                            :swap {:enable true
                                   :swap_next {:<leader>a "@parameter.inner"}
                                   :swap_previous {:<leader>A "@parameter.inner"}}}}]
  (require-then :nvim-treesitter.configs #($.setup config)))

(let [config {:enable true
              :line_numbers true
              :max_lines 2
              :min_window_height 0
              :mode :topline
              :multiline_threshold 20
              :trim_scope :outer
              :zindex 20}]
  (require-then :treesitter-context #($.setup config)))
