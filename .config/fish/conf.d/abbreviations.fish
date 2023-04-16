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

    # npm related ones
    abbr --add n npm
    abbr --add nt 'npm test --'
    abbr --add nrt 'npm run test'
    abbr --add nrw 'npm run watch'
    abbr --add nrl 'npm run lint'
    abbr --add nrd 'npm run docs'
    abbr --add nrp 'npm run prettify -- .'

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
        abbr --add $abb'stp' $cmd 'stash pop'
        abbr --add $abb'std' $cmd 'stash drop'
        abbr --add $abb'stl' $cmd 'stash list'
        abbr --add $abb'sts' $cmd 'stash show'
        abbr --add $abb'sta' $cmd 'stash apply'
    end
    # only git
    abbr --add gaa 'git add --all'
    abbr --add gpb 'git publish'
    abbr --add gb 'git branch'
    abbr --add gbd 'git branch -d'
    abbr --add gbm 'git branch -m'
    abbr --add gco 'git checkout'
    abbr --add gc- 'git checkout -'
    abbr --add gcb 'git checkout -b'
    abbr --add gcd 'git checkout dev'
    abbr --add gcm 'git checkout main'
    abbr --add grbd 'git rebase dev'
    abbr --add grbm 'git rebase main'
    abbr --add grb 'git rebase'
    abbr --add grba 'git rebase --abort'
    abbr --add grbc 'git rebase --continue'
    abbr --add grc 'git recent'
    abbr --add gcl 'git cleaner'

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
