if status --is-interactive
	abbr --add --global .. 'cd ..'
	abbr --add --global dc docker-compose
	abbr --add --global mv 'mv -i'
	abbr --add --global g 'git'
	abbr --add --global reload 'source ~/.config/fish/config.fish'
	abbr --add --global ls exa
	abbr --add --global vim nvim
	abbr --add --global . 'nvim .'
	abbr --add --global cat bat
	abbr --add --global find fd
	# the following is for conditional abbreviations, but does not work with asdf
	# if command -q fd
	# 	abbr --add --global find fd
	# end
end
