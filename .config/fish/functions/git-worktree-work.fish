function git-worktree-work --description 'Change to the work worktree'
    cd (git worktree list | grep '+work' | awk '{print $1}')
end
