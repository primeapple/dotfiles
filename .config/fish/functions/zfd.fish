function zfd --description 'Opens results of fd command in fuzzy finder' --wraps fd
    if set results (fd $argv | zf)
        commandline -f repaint-mode
        echo $results
    else
        return $status
    end
end
