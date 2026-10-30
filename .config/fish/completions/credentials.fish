complete -c credentials -f
complete -c credentials -n __fish_use_subcommand -a set -d 'Store or update a credential'
complete -c credentials -n __fish_use_subcommand -a add -d 'Alias for set'
complete -c credentials -n __fish_use_subcommand -a get -d 'Print a credential value'
complete -c credentials -n __fish_use_subcommand -a remove -d 'Delete a credential'
complete -c credentials -n __fish_use_subcommand -a list -d 'List credential names for current user'
complete -c credentials -n 'test (count (commandline -opc)) -eq 2; and __fish_seen_subcommand_from set add get remove' -a '(credentials list 2>/dev/null | string escape)'
