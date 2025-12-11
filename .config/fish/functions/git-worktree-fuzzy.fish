function git-worktree-fuzzy --description 'Change to the fuzzy worktree'
    cd (git worktree list | grep '+fuzzy' | awk '{print $1}')
end
