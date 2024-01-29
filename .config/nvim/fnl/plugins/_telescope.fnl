(import-macros {: req-do!} :macros)
(import-macros {: map!} :hibiscus.vim)

(local ts (require :telescope))
(local actions (require :telescope.actions))
(local themes (require :telescope.themes))
(local config (require :telescope.config))
(local builtin (require :telescope.builtin))

(local vimgrep-arguments [(unpack config.values.vimgrep_arguments)])
(table.insert vimgrep-arguments :--hidden)
(table.insert vimgrep-arguments :--glob)
(table.insert vimgrep-arguments :!**/.git/*)

(ts.setup {:defaults {:mappings {:i {:<esc> actions.close}}
                      :vimgrep_arguments vimgrep-arguments}
           :pickers {:find_files {:find_command [:rg
                                                 :--files
                                                 :--hidden
                                                 :--glob
                                                 :!**/.git/*]}}})

(pcall (req-do! :telescope #$.load_extension) :fzf)
(map! [:n] :<leader>/
      #(builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false})))

(map! [:n] :<leader>sf builtin.find_files "Find Files")
(map! [:n] :<leader>gf builtin.git_files "Find Git files")
(map! [:n] :<leader>? builtin.help_tags "Search in :h")
(map! [:n] :<leader>sw builtin.grep_string "Search word")
(map! [:n] :<leader>sg builtin.live_grep "Live Grep")
(map! [:n] :<leader>sd builtin.diagnostics "Search diagnostics")
(map! [:n] :<leader>b builtin.buffers "Search buffers")
(map! [:n] :<leader>ss builtin.spell_suggest "Search spell suggestions")
