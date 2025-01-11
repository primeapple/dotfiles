if status --is-interactive
    if command -v qmk >/dev/null
        abbr --add qmkc 'qmk compile -kb splitkb/kyria/rev2 -km primeapple'
        abbr --add qmkf 'qmk flash -kb splitkb/kyria/rev2 -km primeapple -bl avrdude'
    end

    if command -v docker >/dev/null
        abbr --add d docker
        abbr --add dr 'docker run'
        abbr --add db 'docker build'
        abbr --add dc 'docker compose'
        abbr --add dcu 'docker compose up'
        abbr --add dcud 'docker compose up --detach'
        abbr --add dcd 'docker compose down'
    end

    abbr --add reload 'source ~/.config/fish/config.fish'

    if command -v trash-put >/dev/null
        abbr --add rm 'Did you mean trash-put/trash/tp?'
        abbr --add tp trash-put
        abbr --add trash trash-put
    end
    abbr --add mv 'mv -i'
    abbr --add mkdir 'mkdir -pv'
    abbr --add e exit
    abbr --add o xdg-open

    if command -v eza >/dev/null
        abbr --add l eza
        abbr --add ls 'Did you mean eza/l/ll/lll?'
        abbr --add ll 'eza -l'
        abbr --add lll 'eza -la'
    else
        abbr --add l ls
        abbr --add ll 'ls -l'
        abbr --add lll 'ls -la'
    end

    if command -v nvim >/dev/null
        abbr --add . 'nvim .'
    end
    if command -v bat >/dev/null
        abbr --add cat 'Did you mean bat?'
    end

    if command -v pacman >/dev/null
        abbr --add pm pacman
        abbr --add pmi 'sudo pacman -S'
        abbr --add pms 'pacman -Ss'
        abbr --add pmu 'sudo pacman -Syu'
        abbr --add pmr 'sudo pacman -R'
        abbr --add pmq 'pacman -Qs'
    end

    abbr --add cht cht.sh
    abbr --add record 'wf-recorder -g "$(slurp)" -f recording.mp4'
    abbr --add screen 'grim -g "$(slurp)" screenshot.png'
    abbr --add kssh 'kitten ssh'

    # npm related ones
    abbr --add n npm
    abbr --add nt 'npm test --'
    abbr --add nrd 'npm run build'
    abbr --add nrd 'npm run docs'
    abbr --add nrl 'npm run lint'
    abbr --add nrp 'npm run prettify'
    abbr --add nrs 'npm run start'
    abbr --add nrt 'npm run test'
    # Maybe add `--testTimeout=1000000`
    abbr --add nrtd 'npm run test --  --inspect-brk --no-file-parallelism'
    abbr --add nrw 'npm run watch'

    # git/yadm related ones
    for tuples in g,git y,yadm
        echo $tuples | read -d , abb cmd
        abbr --add $abb $cmd
        abbr --add $abb'a' $cmd add
        abbr --add $abb'au' $cmd 'add -u'
        abbr --add $abb'c' $cmd 'commit -v'
        abbr --add $abb'ca' $cmd 'commit --amend'
        abbr --add $abb'can' $cmd 'commit --amend --no-edit'
        abbr --add $abb'r' $cmd reset
        abbr --add $abb'rh' $cmd reset --hard
        abbr --add $abb'rs' $cmd restore
        abbr --add $abb'rst' $cmd 'restore --staged'
        abbr --add $abb'd' $cmd diff
        abbr --add $abb'ds' $cmd 'diff --staged'
        abbr --add $abb'f' $cmd fetch
        abbr --add $abb'pl' $cmd pull
        abbr --add $abb'p' $cmd push
        abbr --add $abb'pf' $cmd 'push --force-with-lease --force-if-includes'
        abbr --add $abb'pff' $cmd 'push --force'
        abbr --add $abb'l' $cmd 'log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative -10'
        abbr --add $abb'lg' $cmd 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit -10'
        abbr --add $abb'ls' $cmd 'log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat -10'
        abbr --add $abb's' $cmd 'status --short --branch'
        abbr --add $abb'st' $cmd 'stash push'
        abbr --add $abb'stm' $cmd 'stash push -m'
        abbr --add $abb'stu' $cmd 'stash push -u'
        abbr --add $abb'stp' $cmd 'stash pop'
        abbr --add $abb'std' $cmd 'stash drop'
        abbr --add $abb'stl' $cmd 'stash list'
        abbr --add $abb'sts' $cmd 'stash show'
        abbr --add $abb'sta' $cmd 'stash apply'
    end

    # only git
    # default branch specific commands
    for tuples in gc,'git checkout' gm,'git merge' grb,'git rebase'
        echo $tuples | read -d , abb cmd
        function _abbr_git_default_branch_$abb --inherit-variable cmd
            if git rev-parse --verify main &> /dev/null
                echo $cmd main
            else
                echo $cmd master
            end
        end
        abbr --add $abb'm' --function _abbr_git_default_branch_$abb
        abbr --add $abb'd' $cmd 'dev'
    end

    abbr --add gaa 'git add --all'
    abbr --add gaf 'git ls-files -m -o --exclude-standard | zf | xargs --no-run-if-empty git add'
    abbr --add gpb 'git publish'
    abbr --add gb 'git branch'
    abbr --add gbd 'git branch -d'
    abbr --add gbm 'git branch -m'
    abbr --add gco 'git checkout'
    abbr --add gc- 'git checkout -'
    abbr --add gcb 'git checkout -b'
    abbr --add gm 'git merge'
    abbr --add gma 'git merge --abort'
    abbr --add grb 'git rebase'
    abbr --add grba 'git rebase --abort'
    abbr --add grbc 'git rebase --continue'
    abbr --add grc 'git recent'
    abbr --add gcl 'git clean -id'
    abbr --add gcp 'git cherry-pick'
    abbr --add gcpn 'git cherry-pick --no-commit'
    abbr --add gclo 'git clone'
    abbr --add gcon 'git config user.name "Toni Müller" && git config user.email "toni.mueller.web@mailbox.org"'

    # only yadm
    abbr --add yaf 'yadm diff --name-only | awk -v home=(echo $HOME) \'{print home "/" $1}\' | zf | xargs --no-run-if-empty yadm add'

    # taskwarrior related ones
    abbr --add t task
    abbr --add tui taskwarrior-tui
    abbr --add ts 'task sync'
    abbr --add ta 'task add'
    abbr --add tn 'task +next'
    abbr --add tin 'clear; task inbox'
    abbr --add tal 'task add dep:"$(task +LATEST uuids)"'

    function __zf_file
        zfd --type file
    end
    abbr --add zf_file --position anywhere --regex "\S*\*\*" --function __zf_file
end
