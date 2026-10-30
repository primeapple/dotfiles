function credentials --description 'Manage credentials in macOS Keychain'
    set -l usage 'Usage: credentials {set|add|get|remove} NAME [VALUE]; credentials list'
    if test (count $argv) -eq 0
        echo "$usage" >&2
        return 2
    end

    switch "$argv[1]"
        case list
            if test (count $argv) -ne 1
                echo "$usage" >&2
                return 2
            end
        case set add
            if test (count $argv) -lt 2; or test (count $argv) -gt 3; or test -z "$argv[2]"
                echo "$usage" >&2
                return 2
            end
        case get remove
            if test (count $argv) -ne 2; or test -z "$argv[2]"
                echo "$usage" >&2
                return 2
            end
        case '*'
            echo "$usage" >&2
            return 2
    end

    if test (command uname -s) != Darwin
        echo 'credentials: not-implemented on this platform' >&2
        return 1
    end

    set -l name
    if set -q argv[2]
        set name "$argv[2]"
    end
    set -l account (command id -un); or return 1
    switch "$argv[1]"
        case list
            # No -d or -r: dump metadata only, never password data.
            set -l metadata (command security dump-keychain); or return $status
            # shortcut: quoted metadata only; add hex decoding if those names become needed.
            printf '%s\n' $metadata | command env CREDENTIALS_ACCOUNT="$account" awk '
                function emit() {
                    if (generic && account == ENVIRON["CREDENTIALS_ACCOUNT"] && service != "")
                        print service
                }
                /^class: / {
                    emit()
                    generic = ($0 == "class: \"genp\"")
                    account = service = ""
                }
                /^[[:space:]]*"acct"<blob>=".*"$/ {
                    sub(/^[^=]*="/, ""); sub(/"$/, ""); account = $0
                }
                /^[[:space:]]*"svce"<blob>=".*"$/ {
                    sub(/^[^=]*="/, ""); sub(/"$/, ""); service = $0
                }
                END { emit() }
            ' | command sort -u
            for code in $pipestatus
                if test "$code" -ne 0
                    return $code
                end
            end
            return 0
        case set add
            set -l value
            if test (count $argv) -eq 3
                set value "$argv[3]"
            else if isatty stdin
                read --silent --prompt-str "Credential for $name: " value; or return 1
            else
                read value; or return 1
            end
            if test -z "$value"
                echo 'credentials: value must not be empty' >&2
                return 2
            end
            command security add-generic-password -U -s "$name" -a "$account" -w "$value"
        case get
            command security find-generic-password -s "$name" -a "$account" -w
        case remove
            command security delete-generic-password -s "$name" -a "$account"
    end
    return $status
end
