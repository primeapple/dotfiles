if status --is-interactive
	abbr --add --global .. 'cd ..'
	abbr --add --global dc docker-compose
	abbr --add --global dm:compile './gradlew compileJava --rerun-tasks --no-build-cache'
	abbr --add --global dm:validate './gradlew spotlessApply checkstyleMain checkstyleTest spotbugsTest checkApiChanges'
	abbr --add --global gw './gradlew -Dconfig.profile=dev-local'
	abbr --add --global mv 'mv -i'
	abbr --add --global g 'git'
	abbr --add --global reload 'source ~/.config/fish/config.fish'
	if command -q exa
		abbr --add --global ls exa
	end
	if command -q nvim
		abbr --add --global vim nvim
	end
	if command -q bat
		abbr --add --global cat bat
	end
	if command -q fd
		abbr --add --global find fd
	end
end
