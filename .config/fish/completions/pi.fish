# Pi command-line completions. Check `pi --help` after upgrading Pi or adding extensions.
complete -c pi -f

function __pi_model_completions
    set -l available (command env PI_OFFLINE=1 pi --list-models 2>/dev/null | awk 'NR > 1 && $1 != "provider" { print $1 "/" $2 }')
    set -l settings_dir ~/.pi/agent
    if set -q PI_CODING_AGENT_DIR
        set settings_dir $PI_CODING_AGENT_DIR
    end
    set -l enabled (command jq -r '.enabledModels[]?' "$settings_dir/settings.json" 2>/dev/null)
    if test (count $enabled) -eq 0
        printf '%s\n' $available
        return
    end
    for model in $available
        for pattern in $enabled
            set pattern (string replace -r ':(off|minimal|low|medium|high|xhigh|max)$' '' -- $pattern)
            if string match -q -- "$pattern" "$model"; or string match -qi -- "*$pattern*" "$model"
                echo $model
                break
            end
        end
    end
end

complete -c pi -s h -l help -d 'Show help'
complete -c pi -s v -l version -d 'Show version'
complete -c pi -s p -l print -d 'Run once and exit'
complete -c pi -s c -l continue -d 'Continue previous session'
complete -c pi -s r -l resume -d 'Select a session to resume'
complete -c pi -s n -l name -r -d 'Set session display name'

complete -c pi -l provider -r -d 'Provider to search for model'
complete -c pi -l model -r -f -a '(__pi_model_completions)' -d 'Select available model'
complete -c pi -l api-key -r -d 'Set API key'
complete -c pi -l system-prompt -r -F -d 'Replace system prompt'
complete -c pi -l append-system-prompt -r -F -d 'Append to system prompt'
complete -c pi -l mode -r -a 'text json rpc' -d 'Select output mode'
complete -c pi -l session -r -F -d 'Open session by path or ID'
complete -c pi -l session-id -r -d 'Set session ID'
complete -c pi -l fork -r -F -d 'Fork session by path or ID'
complete -c pi -l session-dir -r -F -d 'Set session directory'
complete -c pi -l models -r -d 'Set model cycling scope'
complete -c pi -s t -l tools -r -d 'Set enabled tools'
complete -c pi -l exclude-tools -o xt -r -d 'Disable tools'
complete -c pi -l thinking -r -a 'off minimal low medium high xhigh max' -d 'Set thinking level'
complete -c pi -s e -l extension -r -F -d 'Load extension'
complete -c pi -l skill -r -F -d 'Load skill'
complete -c pi -l prompt-template -r -F -d 'Load prompt template'
complete -c pi -l theme -r -F -d 'Load theme'
complete -c pi -l use-theme -r -d 'Set initial theme'
complete -c pi -l export -r -F -d 'Export session to HTML'
complete -c pi -l list-models -d 'List available models'
complete -c pi -l tui-mode -r -a 'fullscreen regular' -d 'Set TUI mode'

complete -c pi -l no-session -d 'Do not save session'
complete -c pi -l no-tools -o nt -d 'Disable all tools'
complete -c pi -l no-builtin-tools -o nbt -d 'Disable built-in tools'
complete -c pi -l no-extensions -o ne -d 'Disable extensions'
complete -c pi -l no-skills -o ns -d 'Disable skills'
complete -c pi -l no-prompt-templates -o np -d 'Disable prompt templates'
complete -c pi -l no-themes -d 'Disable themes'
complete -c pi -l no-context-files -o nc -d 'Disable context files'
complete -c pi -l verbose -d 'Show verbose startup information'
complete -c pi -s a -l approve -d 'Trust project-local files'
complete -c pi -l no-approve -o na -d 'Ignore project-local files'
complete -c pi -l offline -d 'Disable startup network activity'

complete -c pi -n '__fish_use_subcommand' -a 'install remove uninstall update list config auth mcp'
complete -c pi -n '__fish_seen_subcommand_from auth' -a 'check print-api-key print-bearer-token'
complete -c pi -n '__fish_seen_subcommand_from mcp' -a 'list add remove login logout'
complete -c pi -n '__fish_seen_subcommand_from install remove uninstall config' -s l -l local -d 'Use project settings'
