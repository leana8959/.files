(local {: require-then} (require :helpers))

(local conf
  { :default_file_explorer false
    :columns []
    :skip_confirm_for_simple_edits true
    :prompt_save_on_select_new_entry false
    :view_options {:show_hidden true}
    :keymaps
      { "g?"    "actions.show_help"
        "<CR>"  "actions.select"
        "<C-v>" "actions.select_vsplit"
        "<C-x>" "actions.select_split"
        "<C-t>" "actions.select_tab"
        "<C-p>" "actions.preview"
        "<C-c>" "actions.close"
        "<C-l>" "actions.refresh"
        "-"     "actions.parent"
        "_"     "actions.open_cwd"
        "`"     "actions.cd"
        "~"     "actions.tcd"
        "gs"    "actions.change_sort"
        "gx"    "actions.open_external"
        "g."    "actions.toggle_hidden"
        "g\\"   "actions.toggle_trash"
      }
  })

(require-then :oil #($.setup conf))
