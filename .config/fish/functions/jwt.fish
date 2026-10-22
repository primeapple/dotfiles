function __jwt_decode_segment
    jq -cR '
        gsub("-"; "+")
        | gsub("_"; "/")
        | . + ("==="[:((4 - length % 4) % 4)])
        | @base64d
        | fromjson
        | if type == "object" then . else error("JWT segment must be a JSON object") end
    '
end

function __jwt_date
    if test (uname) = Darwin
        TZ=UTC command date -r "$argv[1]" '+%Y-%m-%dT%H:%M:%SZ'
    else
        TZ=UTC command date -d "@$argv[1]" '+%Y-%m-%dT%H:%M:%SZ'
    end
end

function jwt --description 'Decode a JWT without verifying its signature'
    if test (count $argv) -ne 2; or test "$argv[1]" != decode
        echo 'Usage: jwt decode TOKEN' >&2
        return 2
    end

    if not string match -rq '^[^.]+\.[^.]+\.[^.]+$' -- "$argv[2]"
        echo 'Error: expected a JWT with three non-empty segments' >&2
        return 2
    end

    set -l parts (string split '.' -- "$argv[2]")
    set -l header (printf '%s' "$parts[1]" | __jwt_decode_segment); or return 1
    set -l payload (printf '%s' "$parts[2]" | __jwt_decode_segment); or return 1

    echo 'Header:'
    printf '%s\n' "$header" | jq .
    echo 'Payload:'
    printf '%s\n' "$payload" | jq .

    for claim in iat exp
        set -l timestamp (printf '%s\n' "$payload" | jq -r --arg claim "$claim" '.[$claim] | if type == "number" then floor else empty end')
        if test -n "$timestamp"
            set -l label
            if test "$claim" = iat
                set label 'Issued at'
            else
                set label 'Expires at'
            end
            set -l readable (__jwt_date "$timestamp"); or return 1
            printf '%s (%s): %s\n' "$label" "$claim" "$readable"
        end
    end
end
