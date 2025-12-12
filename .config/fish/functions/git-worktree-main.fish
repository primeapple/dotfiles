function git-worktree-main --description 'Change to the main/master worktree'
    if git rev-parse --verify main &>/dev/null
        cd (git worktree list | grep '+main' | awk '{print $1}')
    else
        cd (git worktree list | grep '+master' | awk '{print $1}')
    end
end
