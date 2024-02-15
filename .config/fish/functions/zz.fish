function zz --description 'Opens fuzzy finder of visited places, cd into the selected one'
    cd (z --list | sort -g -r | awk '{print $2}' | zf)
end
