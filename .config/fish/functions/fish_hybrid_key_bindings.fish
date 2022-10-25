# snippet from https://fishshell.com/docs/current/interactive.html#command-line-editor
function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase

    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
end
