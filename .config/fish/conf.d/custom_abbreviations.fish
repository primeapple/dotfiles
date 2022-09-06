if status --is-interactive
    # applications
	abbr --add --global dc docker-compose
	abbr --add --global mv 'mv -i'
	abbr --add --global g 'git'
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
end
