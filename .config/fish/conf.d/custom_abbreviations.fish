if status --is-interactive
    # applications
	abbr --add --global dc docker-compose
	abbr --add --global mv 'mv -i'
	abbr --add --global reload 'source ~/.config/fish/config.fish'
	abbr --add --global ls exa
	abbr --add --global vim nvim
	abbr --add --global . 'nvim .'
	abbr --add --global cat bat
	abbr --add --global find fd
	abbr --add --global cht cht.sh
    abbr --add --global record 'wf-recorder -g "$(slurp)"'
    abbr --add --global screen 'grim -g "$(slurp)" screenshot.png'

    # npm related ones
    abbr --add --global n 'npm'
    abbr --add --global nt 'npm test --'
    abbr --add --global nrt 'npm run test'
    abbr --add --global nrw 'npm run watch'
    abbr --add --global nrl 'npm run lint'
    abbr --add --global nrd 'npm run docs'
    abbr --add --global nrp 'npm run prettify -- .'

    # git/yadm related ones
    for tuples in g,git y,yadm
        echo $tuples | read -d , abb cmd
        abbr --add --global $abb $cmd
        abbr --add --global $abb'a' $cmd 'add'
        abbr --add --global $abb'aa' $cmd 'add --all'
        abbr --add --global $abb'au' $cmd 'add -u'
        abbr --add --global $abb'c' $cmd 'commit -v'
        abbr --add --global $abb'can' $cmd 'commit --amend --no-edit'
        abbr --add --global $abb'r' $cmd 'reset'
        abbr --add --global $abb'rs' $cmd 'restore'
        abbr --add --global $abb'rst' $cmd 'restore --staged'
        abbr --add --global $abb'rb' $cmd 'rebase'
        abbr --add --global $abb'rba' $cmd 'rebase --abort'
        abbr --add --global $abb'rbc' $cmd 'rebase --continue'
        abbr --add --global $abb'rc' $cmd 'recent'
        abbr --add --global $abb'd' $cmd 'diff'
        abbr --add --global $abb'ds' $cmd 'diff --staged'
        abbr --add --global $abb'f' $cmd 'fetch'
        abbr --add --global $abb'pl' $cmd 'pull'
        abbr --add --global $abb'p' $cmd 'push'
        abbr --add --global $abb'pf' $cmd 'push --force'
        abbr --add --global $abb'l' $cmd 'log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative'
        abbr --add --global $abb'lg' $cmd 'log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
        abbr --add --global $abb'ls' $cmd 'log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
        abbr --add --global $abb's' $cmd 'status --short --branch'
        abbr --add --global $abb'st' $cmd 'stash'
        abbr --add --global $abb'stp' $cmd 'stash pop'
        abbr --add --global $abb'std' $cmd 'stash drop'
        abbr --add --global $abb'stl' $cmd 'stash list'
        abbr --add --global $abb'sts' $cmd 'stash show'
        abbr --add --global $abb'sta' $cmd 'stash apply'
    end
    # only git
    abbr --add --global gpb 'git publish'
    abbr --add --global gb 'git branch'
    abbr --add --global gbd 'git branch -d'
    abbr --add --global gbm 'git branch -m'
    abbr --add --global gco 'git checkout'
    abbr --add --global gc- 'git checkout -'
    abbr --add --global gcb 'git checkout -b'
    abbr --add --global gcd 'git checkout dev'
    abbr --add --global gcm 'git checkout main'
    abbr --add --global grbd 'rebase dev'
    abbr --add --global grbm 'rebase main'

    # taskwarrior related ones
    # https://www.reddit.com/r/taskwarrior/comments/uvwqlz/share_your_aliases/
    abbr --add --global t 'task'
    abbr --add --global tui 'taskwarrior-tui'
    abbr --add --global ts 'task sync'
    abbr --add --global ta 'task add'
    abbr --add --global tn 'task +next'
    abbr --add --global tin 'clear; task inbox'
    abbr --add --global tal 'task add dep:"$(task +LATEST uuids)"'
end
