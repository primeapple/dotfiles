function git-worktree-add --argument-names branch --description 'Create a new worktree for the given branch, if none is given open the current branch in new worktree'
    set root (git rev-parse --show-toplevel)
    set parent_dir (dirname $root)
    set repo_name (basename $parent_dir)
    
    if set --query branch[1]
        # open branch in new worktree
        set new_worktree_path $parent_dir/$repo_name+$branch
        git worktree add -b $branch $new_worktree_path
    else
        # open current branch in new worktree, reset to parking branch
        set branch (git branch --show-current)
        set new_worktree_path $parent_dir/$repo_name+$branch
        git park
        git worktree add $new_worktree_path $branch 
    end

    cd $new_worktree_path
end
