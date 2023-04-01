# snippet from https://fishshell.com/docs/current/interactive.html#command-line-editor
function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings --mode $mode
    end
    fish_vi_key_bindings --no-erase

    for mode in default insert visual
        # 't' stands for tidy
        bind --mode $mode \ct 'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'
    end
    bind yy fish_clipboard_copy
    bind --mode visual y fish_clipboard_copy
    bind p fish_clipboard_paste
    bind H beginning-of-line
    bind L end-of-line
    bind --mode visual H beginning-of-line
    bind --mode visual L end-of-line

end
