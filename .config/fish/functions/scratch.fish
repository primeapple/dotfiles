function scratch --description 'Creates scratch file and open in nvim'
    set file "$(mktemp)"
    echo "Editing $file"
    "$EDITOR" "$file"
end
