if status --is-interactive
    # applications
    abbr --add d docker
    abbr --add dc 'docker compose'
    abbr --add dcu 'docker compose up'
    abbr --add dcud 'docker compose down -d'
    abbr --add mv 'mv -i'
    abbr --add reload 'source ~/.config/fish/config.fish'

    if command -v eza >/dev/null
        abbr -a l eza
        abbr -a ls eza
        abbr -a ll 'eza -l'
        abbr -a lll 'eza -la'
    else
        abbr -a l ls
        abbr -a ll 'ls -l'
        abbr -a lll 'ls -la'
    end
    if command -v nvim >/dev/null
        abbr -a vim nvim
        abbr --add . 'nvim .'
    end
    if command -v bat >/dev/null
        abbr --add cat bat
    end
    if command -v fd >/dev/null
        abbr --add find fd
    end
    abbr --add cht cht.sh
    abbr --add record 'wf-recorder -g "$(slurp)" -f recording.mp4'
    abbr --add screen 'grim -g "$(slurp)" screenshot.png'
    abbr --add fz 'fd . | fzy | xargs'
    abbr --add fzz "cd (z --list | sort -g -r | awk '{print \$2}' | fzy)"
    abbr --add kssh "kitten ssh"

    # npm related ones
    abbr --add n npm
    abbr --add nt 'npm test --'
    abbr --add nrd 'npm run build'
    abbr --add nrd 'npm run docs'
    abbr --add nrj 'fd "\.test\." -e js -e ts -e jsx | fzy | xargs -r npx jest'
    abbr --add nrl 'npm run lint'
    abbr --add nrp 'npm run prettify'
    abbr --add nrs 'npm run start'
    abbr --add nrt 'npm run test'
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
    # branch specific commands
    for tuples in m,main ma,master d,dev
        echo $tuples | read -d , abb branch
        abbr --add 'gc'$abb 'git checkout' $branch
        abbr --add 'grb'$abb 'git rebase' $branch
        abbr --add 'gm'$abb 'git merge' $branch
        abbr --add 'gpu'$abb 'git pull upstream' $branch
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
    abbr --add grb 'git rebase'
    abbr --add gma 'git merge --abort'
    abbr --add grba 'git rebase --abort'
    abbr --add grbc 'git rebase --continue'
    abbr --add grc 'git recent'
    abbr --add gcl 'git clean -id'
    abbr --add gcp 'git cherry-pick'
    abbr --add gcpn 'git cherry-pick --no-commit'
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

    # fuzzy finder
    function __zf_wrapper
        fd | zf
    end
    abbr --add zf_in_directory --position anywhere --regex "\S*\*\*" --function __zf_wrapper
end
