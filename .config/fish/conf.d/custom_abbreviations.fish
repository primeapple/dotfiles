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

    # npm related ones
    abbr --add --global nj 'npx jest'
    abbr --add --global nrt 'npm run test'
    abbr --add --global nrw 'npm run watch'
    abbr --add --global nrl 'npm run lint'
    abbr --add --global nrd 'npm run docs'

    # git related ones
	abbr --add --global g 'git'
    abbr --add --global ga 'git add'
    abbr --add --global gaa 'git add --all'
    abbr --add --global gb 'git branch'
    abbr --add --global gc 'git commit -v -m'
    abbr --add --global gcan 'git commit --amend --no-edit'
    abbr --add --global gcb 'git checkout -b'
    abbr --add --global gcd 'git checkout dev'
    abbr --add --global gcm 'git checkout main'
    abbr --add --global gc- 'git checkout -'
    abbr --add --global gco 'git checkout'
    abbr --add --global gr 'git rebase'
    abbr --add --global gra 'git rebase --abort'
    abbr --add --global grc 'git rebase --continue'
    abbr --add --global gd 'git diff'
    abbr --add --global gds 'git diff --staged'
    abbr --add --global gf 'git fetch'
    abbr --add --global gl 'git pull --ff-only'
    abbr --add --global glr 'git pull --rebase'
    abbr --add --global glg 'git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative'
    abbr --add --global gll 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
    abbr --add --global gls 'git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
    abbr --add --global gp 'git push'
    abbr --add --global gpf 'git push --force'
    abbr --add --global gpb 'git publish'
    abbr --add --global gst 'git status --short --branch'
end
