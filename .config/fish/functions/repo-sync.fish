function repo-sync --description 'Pull updates for clean Git repositories and report changes, branches, and stashes'
    if test (count $argv) -eq 0
        echo 'Usage: repo-sync REPO [REPO ...]' >&2
        return 2
    end

    set -l failed 0
    for repo in $argv
        if not test -d "$repo"
            printf 'repo-sync: not a directory: %s\n' "$repo" >&2
            set failed 1
            continue
        end
        if not command git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1
            printf 'repo-sync: not a Git working tree: %s\n' "$repo" >&2
            set failed 1
            continue
        end

        set -l prefix (command git -C "$repo" rev-parse --show-prefix 2>/dev/null)
        if test -n "$prefix"
            printf 'repo-sync: path is inside a repository, not its root: %s\n' "$repo" >&2
            set failed 1
            continue
        end

        set -l repo_path (command git -C "$repo" rev-parse --show-toplevel)
        echo "$repo_path"

        set -l staged (command git -C "$repo" diff --cached --name-only -z | string split0 | count)
        set -l unstaged (command git -C "$repo" diff --name-only -z | string split0 | count)
        set -l untracked (command git -C "$repo" ls-files --others --exclude-standard -z | string split0 | count)
        if test "$staged" -gt 0; or test "$unstaged" -gt 0; or test "$untracked" -gt 0
            printf '  files: %s staged, %s unstaged, %s untracked\n' "$staged" "$unstaged" "$untracked"
        end

        set -l current (command git -C "$repo" branch --show-current)
        set -l default (command git -C "$repo" symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null | command sed 's@^refs/remotes/origin/@@')
        if test "$staged" -eq 0; and test "$unstaged" -eq 0; and test "$untracked" -eq 0; and test -n "$current"
            set -l should_pull 1
            if test -n "$default"; and test "$current" != "$default"
                read -P "Switch from $current to default branch '$default'? [y/n] " answer
                switch (string lower -- "$answer")
                    case y
                        if command git -C "$repo" checkout "$default"
                            set current "$default"
                            printf '  switched to: %s\n' "$default"
                        else
                            printf 'repo-sync: failed to checkout %s in %s\n' "$default" "$repo" >&2
                            set failed 1
                            set should_pull 0
                        end
                    case n
                    case '*'
                        echo 'repo-sync: answer y or n; leaving branch unchanged' >&2
                        set should_pull 0
                end
            end
            if test "$should_pull" -eq 1
                set -l upstream (command git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null)
                if test -n "$upstream"
                    if command git -C "$repo" pull --ff-only
                        printf '  pulled: %s\n' "$current"
                    else
                        printf 'repo-sync: failed to pull current branch in %s\n' "$repo" >&2
                        set failed 1
                    end
                end
            end
        end

        if test -z "$current"
            echo '  branch: detached HEAD'
        else if test -z "$default"
            printf '  default branch unknown (origin/HEAD unset; current: %s)\n' "$current"
        else if test "$current" != "$default"
            printf '  branch: %s (default: %s)\n' "$current" "$default"
        end

        set -l stashes (command git -C "$repo" stash list --format='%s')
        if test (count $stashes) -gt 0
            printf '  stashes: %s\n' (count $stashes)
            printf '    %s\n' $stashes
        end
    end

    return $failed
end
