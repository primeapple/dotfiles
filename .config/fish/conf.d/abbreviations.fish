if status --is-interactive
    # applications
    abbr --add dc docker-compose
    abbr --add mv 'mv -i'
    abbr --add reload 'source ~/.config/fish/config.fish'
    abbr --add ls exa
    abbr --add vim nvim
    abbr --add . 'nvim .'
    abbr --add cat bat
    abbr --add find fd
    abbr --add cht cht.sh
    abbr --add record 'wf-recorder -g "$(slurp)"'
    abbr --add screen 'grim -g "$(slurp)" screenshot.png'
    abbr --add fz 'fd . | fzy | xargs'
    abbr --add fzz "cd (z --list | sort -g -r | awk '{print \$2}' | fzy)"


    # npm related ones
    abbr --add n npm
    abbr --add nt 'npm test --'
    abbr --add nrt 'npm run test'
    abbr --add nrw 'npm run watch'
    abbr --add nrl 'npm run lint'
    abbr --add nrd 'npm run docs'
    abbr --add nrp 'npm run prettify -- .'
    abbr --add nrj 'fd "\.test\." -e js -e ts -e jsx | fzy | xargs -r npx jest'

    # git/yadm related ones
    for tuples in g,git y,yadm
        echo $tuples | read -d , abb cmd
        abbr --add $abb $cmd
        abbr --add $abb'a' $cmd add
        abbr --add $abb'au' $cmd 'add -u'
        abbr --add $abb'c' $cmd 'commit -v'
        abbr --add $abb'can' $cmd 'commit --amend --no-edit'
        abbr --add $abb'r' $cmd reset
        abbr --add $abb'rs' $cmd restore
        abbr --add $abb'rst' $cmd 'restore --staged'
        abbr --add $abb'd' $cmd diff
        abbr --add $abb'ds' $cmd 'diff --staged'
        abbr --add $abb'f' $cmd fetch
        abbr --add $abb'pl' $cmd pull
        abbr --add $abb'p' $cmd push
        abbr --add $abb'pf' $cmd 'push --force-with-lease --force-if-includes'
        abbr --add $abb'l' $cmd 'log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative'
        abbr --add $abb'lg' $cmd 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
        abbr --add $abb'ls' $cmd 'log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
        abbr --add $abb's' $cmd 'status --short --branch'
        abbr --add $abb'st' $cmd stash
        abbr --add $abb'stpu' $cmd 'stash push -m'
        abbr --add $abb'stp' $cmd 'stash pop'
        abbr --add $abb'std' $cmd 'stash drop'
        abbr --add $abb'stl' $cmd 'stash list'
        abbr --add $abb'sts' $cmd 'stash show'
        abbr --add $abb'sta' $cmd 'stash apply'
        abbr --add $abb'stu' $cmd 'stash -u'
    end
    # only git
    abbr --add gaa 'git add --all'
    abbr --add gaf 'git ls-files -m -o --exclude-standard | fzf | xargs --no-run-if-empty git add'
    abbr --add gpb 'git publish'
    abbr --add gb 'git branch'
    abbr --add gbd 'git branch -d'
    abbr --add gbm 'git branch -m'
    abbr --add gco 'git checkout'
    abbr --add gc- 'git checkout -'
    abbr --add gcb 'git checkout -b'
    abbr --add gcd 'git checkout dev'
    abbr --add gcm 'git checkout main'
    abbr --add grb 'git rebase'
    abbr --add grbd 'git rebase dev'
    abbr --add grbm 'git rebase main'
    abbr --add gpud 'git pull upstream dev'
    abbr --add gpum 'git pull upstream main'
    abbr --add grba 'git rebase --abort'
    abbr --add grbc 'git rebase --continue'
    abbr --add grc 'git recent'
    abbr --add gcl 'git cleaner'
    abbr --add gcp 'git cherry-pick'
    abbr --add gcpn 'git cherry-pick --no-commit'
    # only yadm
    abbr --add yaf 'yadm diff --name-only | awk -v home=(echo $HOME) \'{print home "/" $1}\' | fzf | xargs --no-run-if-empty yadm add'

    # taskwarrior related ones
    # https://www.reddit.com/r/taskwarrior/comments/uvwqlz/share_your_aliases/
    abbr --add t task
    abbr --add tui taskwarrior-tui
    abbr --add ts 'task sync'
    abbr --add ta 'task add'
    abbr --add tn 'task +next'
    abbr --add tin 'clear; task inbox'
    abbr --add tal 'task add dep:"$(task +LATEST uuids)"'
end
