function cfd --description 'Open subdirectories in fuzzy finder and cd into the selected one'
    cd (fd --type directory | zf)
end
