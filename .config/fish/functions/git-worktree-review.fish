function git-worktree-review --description 'Change to the review worktree'
    cd (git worktree list | grep '+review' | awk '{print $1}')
end
