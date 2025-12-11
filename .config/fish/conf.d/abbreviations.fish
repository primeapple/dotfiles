if status --is-interactive
    if command -v qmk >/dev/null
        abbr --add qmkc 'qmk compile -kb splitkb/kyria/rev2 -km primeapple'
        abbr --add qmkf 'qmk flash -kb splitkb/kyria/rev2 -km primeapple -bl avrdude'
    end

    if command -v docker >/dev/null
        abbr --add --set-cursor dcdp 'docker compose --profile % down'
        abbr --add --set-cursor dcup 'docker compose --profile % up'
        abbr --add d docker
        abbr --add db 'docker build'
        abbr --add dc 'docker compose'
        abbr --add dcd 'docker compose down'
        abbr --add dcl 'docker compose logs'
        abbr --add dcls 'docker compose ls'
        abbr --add dcp 'docker compose ps'
        abbr --add dcpl 'docker compose pull'
        abbr --add dcu 'docker compose up'
        abbr --add dcud 'docker compose up --detach'
        abbr --add dr 'docker run'
    end

    function __maven_abbr
        if test -f './mvnw'
            echo './mvnw'
        else
            echo mvn
        end
    end
    abbr --add mvn --function __maven_abbr

    abbr --add sudoedit 'EDITOR=(which nvim) sudoedit'

    abbr --add reload 'source ~/.config/fish/config.fish'

    if command -v trash-put >/dev/null
        abbr --add rm 'echo Did you mean trash-put/trash/tp? && rm'
        abbr --add tp trash-put
        abbr --add trash trash-put
    end
    abbr --add mv 'mv -i'
    abbr --add mkdir 'mkdir -pv'
    abbr --add e exit
    abbr --add o xdg-open

    if command -v eza >/dev/null
        abbr --add l eza
        abbr --add ll 'eza -l'
        abbr --add lll 'eza -la'
        abbr --add ls 'Did you mean eza/l/ll/lll?'
    else
        abbr --add l ls
        abbr --add ll 'ls -l'
        abbr --add lll 'ls -la'
    end

    if command -v nvim >/dev/null
        abbr --add . 'nvim .'
    end
    if command -v bat >/dev/null
        abbr --add cat 'bat -p'
    end

    if command -v pacman >/dev/null
        abbr --add pm pacman
        abbr --add pmi 'sudo pacman -S'
        abbr --add pmq 'pacman -Qs'
        abbr --add pmr 'sudo pacman -R'
        abbr --add pms 'pacman -Ss'
        abbr --add pmu 'sudo pacman -Syu'
    end

    abbr --add cht cht.sh
    abbr --add record 'wf-recorder -g "$(slurp)" -f recording.mp4'
    abbr --add screen 'grim -g "$(slurp)" screenshot.png'
    abbr --add kssh 'kitten ssh'

    # npm related ones
    abbr --add n npm
    abbr --add nrd 'npm run build'
    abbr --add nrd 'npm run docs'
    abbr --add nrl 'npm run lint'
    abbr --add nrp 'npm run prettify'
    abbr --add nrs 'npm run start'
    abbr --add nrt 'npm run test'
    # Maybe add `--testTimeout=1000000`
    abbr --add nrtd 'npm run test --  --inspect-brk --no-file-parallelism'
    abbr --add nrw 'npm run watch'
    abbr --add nt 'npm test --'

    # git/yadm related ones
    for tuples in g,git y,yadm
        echo $tuples | read -d , abb cmd

        abbr --add $abb $cmd
        abbr --add $abb'a' $cmd add
        abbr --add $abb'au' $cmd 'add --update'
        abbr --add $abb'c' $cmd 'commit --verbose'
        abbr --add $abb'ca' $cmd 'commit --amend'
        abbr --add $abb'can' $cmd 'commit --amend --no-edit'
        abbr --add $abb'd' $cmd diff
        abbr --add $abb'ds' $cmd 'diff --staged'
        abbr --add $abb'f' $cmd fetch
        abbr --add $abb'l' $cmd 'log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative -10'
        abbr --add $abb'lg' $cmd 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit -10'
        abbr --add $abb'ls' $cmd 'log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat -10'
        abbr --add $abb'p' $cmd push
        abbr --add $abb'pf' $cmd 'push --force-with-lease --force-if-includes'
        abbr --add $abb'pff' $cmd 'push --force'
        abbr --add $abb'pl' $cmd pull
        abbr --add $abb'plr' $cmd 'pull --rebase'
        abbr --add $abb'pt' $cmd 'push --follow-tags'
        abbr --add $abb'r' $cmd reset
        abbr --add $abb'rh' $cmd 'reset --hard'
        abbr --add $abb'rs' $cmd restore
        abbr --add $abb'rst' $cmd 'restore --staged'
        abbr --add $abb's' $cmd 'status --short --branch'
        abbr --add $abb'st' $cmd 'stash push'
        abbr --add $abb'sta' $cmd 'stash apply'
        abbr --add $abb'std' $cmd 'stash drop'
        abbr --add $abb'stl' $cmd 'stash list'
        abbr --add $abb'stm' $cmd 'stash push -m'
        abbr --add $abb'stp' $cmd 'stash pop'
        abbr --add $abb'sts' $cmd 'stash show'
        abbr --add $abb'stu' $cmd 'stash push -u'
    end

    # only git
    # default branch specific commands
    for tuples in gs,'git switch' gm,'git merge' grb,'git rebase'
        echo $tuples | read -d , abb cmd
        function _abbr_git_default_branch_$abb --inherit-variable cmd
            if git rev-parse --verify main &>/dev/null
                echo $cmd main
            else
                echo $cmd master
            end
        end
        abbr --add $abb'm' --function _abbr_git_default_branch_$abb
        abbr --add $abb'd' $cmd dev
    end

    abbr --add gaa 'git add --all'
    abbr --add gb 'git branch'
    abbr --add gbd 'git branch --delete'
    abbr --add gbm 'git branch --move'
    abbr --add gcl 'git clean -id'
    abbr --add gclo 'git clone'
    abbr --add gco 'git checkout'
    abbr --add gcon 'git config user.name "Toni Müller" && git config user.email "toni.mueller.web@mailbox.org"'
    abbr --add gcp 'git cherry-pick'
    abbr --add gcpn 'git cherry-pick --no-commit'
    abbr --add gi 'git init'
    abbr --add gm 'git merge'
    abbr --add gma 'git merge --abort'
    abbr --add gpb 'git publish'
    abbr --add grb 'git rebase'
    abbr --add grba 'git rebase --abort'
    abbr --add grbc 'git rebase --continue'
    abbr --add grc 'git recent'
    abbr --add gs- 'git switch -'
    abbr --add gsc 'git switch --create'
    abbr --add gse 'git select'
    abbr --add gsq 'git squash'
    abbr --add gsw 'git switch'
    abbr --add guw 'git unwip'
    abbr --add gw 'git wip'
    abbr --add gwt 'git worktree'
    abbr --add gwta 'git worktree add'
    abbr --add gwtf 'git-worktree-fuzzy'
    abbr --add gwtl 'git worktree list'
    abbr --add gwtm 'git-worktree-main'
    abbr --add gwtr 'git worktree remove'
    abbr --add gwtw 'git-worktree-work'

    # only yadm
    abbr --add yse 'yadm diff --name-only | awk -v home=(echo $HOME) \'{print home "/" $1}\' | zf | xargs --no-run-if-empty yadm add'

    # taskwarrior related ones
    abbr --add t task
    abbr --add ta 'task add'
    abbr --add tal 'task add dep:"$(task +LATEST uuids)"'
    abbr --add tin 'clear; task inbox'
    abbr --add tn 'task +next'
    abbr --add ts 'task sync'
    abbr --add tui taskwarrior-tui

    function __zf_file
        zfd --type file
    end
    abbr --add zf_file --position anywhere --regex "\S*\*\*" --function __zf_file
end
