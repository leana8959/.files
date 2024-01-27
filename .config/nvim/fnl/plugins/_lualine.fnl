(local {: require-then : fst} (require :helpers))

(fn diagnostic-message []
  (let [{: row} (vim.api.nvim_win_get_cursor 0)
        ds (vim.diagnostic.get 0 {:lnum (- row 1)})]
    (if (>= (length ds) 1) (: (. (fst ds) :message) :gsub "%%" "%%%%") "")))

(local grey {:a {:bg "#e4e4e5"}
             :b {:bg "#e4e4e5"}
             :c {:bg "#e4e4e5"}
             :x {:bg "#e4e4e5"}
             :y {:bg "#e4e4e5"}
             :z {:bg "#e4e4e5"}})

(local curry-theme {:inactive grey
                    :insert grey
                    :normal grey
                    :replace grey
                    :visual grey})

(local sections {:lualine_a {}
                 :lualine_b [{1 :diagnostics
                              :colored true
                              :symbols {:error :E :hint :H :info "·" :warn :W}}
                             diagnostic-message]
                 :lualine_c [:navic]
                 :lualine_x {}
                 :lualine_y {}
                 :lualine_z [:progress :branch]})

(let [config {:extensions {}
              :inactive_sections sections
              :inactive_winbar {}
              :options {:always_divide_middle true
                        :component_separators {}
                        :disabled_filetypes {:statusline [:fugitive]
                                             :winbar [:fugitive]}
                        :globalstatus false
                        :icons_enabled true
                        :ignore_focus {}
                        :refresh {:statusline 1000 :tabline 1000 :winbar 1000}
                        :section_separators {}
                        :theme curry-theme}
              : sections
              :tabline {}
              :winbar {}}]
  (require-then :lualine #($.setup config)))
