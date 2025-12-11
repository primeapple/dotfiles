function git-worktree-main --description 'Change to the main worktree'
    cd (git worktree list | grep '+main' | awk '{print $1}')
end
