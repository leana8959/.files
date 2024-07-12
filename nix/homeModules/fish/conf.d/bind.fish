for mode in default insert
    bind --mode $mode \cg tmux_home
    bind --mode $mode \cf tmux_sessionizer
end

# vi cursor style
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
