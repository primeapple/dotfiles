function __fish_kopia_complete -d 'Generate completions via kopia'
    set -l tokens (commandline -o)
    if test (count $tokens) -le 1
        kopia --completion-bash 2>/dev/null
    else
        kopia --completion-bash $tokens[2..-1] 2>/dev/null
    end
end

complete -c kopia -a '(__fish_kopia_complete)'
