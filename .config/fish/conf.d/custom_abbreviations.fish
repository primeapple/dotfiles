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

    # git related ones
	abbr --add --global g 'git'
    abbr --add --global ga 'git add'
    abbr --add --global gaa 'git add --all'
    abbr --add --global gb 'git branch'
    abbr --add --global gbd 'git branch -d'
    abbr --add --global gc 'git commit -v'
    abbr --add --global gcan 'git commit --amend --no-edit'
    abbr --add --global gcb 'git checkout -b'
    abbr --add --global gcd 'git checkout dev'
    abbr --add --global gcm 'git checkout main'
    abbr --add --global gc- 'git checkout -'
    abbr --add --global gco 'git checkout'
    abbr --add --global gr 'git reset'
    abbr --add --global grs 'git restore'
    abbr --add --global grst 'git restore --staged'
    abbr --add --global grb 'git rebase'
    abbr --add --global grbd 'git rebase dev'
    abbr --add --global grbm 'git rebase main'
    abbr --add --global grba 'git rebase --abort'
    abbr --add --global grbc 'git rebase --continue'
    abbr --add --global grc 'git recent'
    abbr --add --global gd 'git diff'
    abbr --add --global gds 'git diff --staged'
    abbr --add --global gf 'git fetch'
    abbr --add --global gpl 'git pull --ff-only'
    abbr --add --global gpr 'git pull --rebase'
    abbr --add --global gp 'git push'
    abbr --add --global gpf 'git push --force'
    abbr --add --global gpb 'git publish'
    abbr --add --global gl 'git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative'
    abbr --add --global glg 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
    abbr --add --global gls 'git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
    abbr --add --global gs 'git status --short --branch'
    abbr --add --global gst 'git stash'
    abbr --add --global gstp 'git stash pop'
    abbr --add --global gstd 'git stash drop'
    abbr --add --global gstl 'git stash list'
    abbr --add --global gsts 'git stash show'
    abbr --add --global gsta 'git stash apply'
end
