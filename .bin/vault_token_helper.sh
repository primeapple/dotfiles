#!/bin/bash

# Inspired by https://developer.hashicorp.com/vault/docs/commands/token-helper#example-token-helper

function write_error(){ >&2 echo "$@"; }

# Customize the hash key for tokens. Currently, we remove the strings
# 'https://', '.', and ':' from the passed Vault address 
# because jq has trouble with special characters in JSON field names
function createHashKey {
    local key="${VAULT_ADDR}"

    if [[ -z "${key}" ]] ; then
        write_error "Error: VAULT_ADDR environment variable unset."
        exit 100
    fi

    key=${key//"http://"/""}
    key=${key//"https://"/""}
    key=${key//"."/"_"}
    key=${key//":"/"_"}

    echo "addr-${key}"
}

TOKEN_FILE="${HOME}/.vault-tokens"
KEY=$(createHashKey)
TOKEN="null"

# If the token file does not exist, create it
if [ ! -f "${TOKEN_FILE}" ] ; then
    echo "{}" > "${TOKEN_FILE}"
fi

case "${1}" in
    "get")
        # Read the current JSON data and pull the token associated with ${KEY}
        TOKEN=$(jq --arg key "${KEY}" -r '.[$key]' "${TOKEN_FILE}")

        # If the token != to the string "null", print the token to stdout 
        # jq returns "null" if the key was not found in the JSON data
        if [ ! "${TOKEN}" == "null" ] ; then
            echo -n "${TOKEN}"
        fi
        exit 0
    ;;

    "store")
        # Get the token from stdin
        read TOKEN

        # Read the current JSON data and add a new entry
        JSON=$(
            jq                      \
            --arg key "${KEY}"      \
            --arg token "${TOKEN}"  \
            '.[$key] = $token' "${TOKEN_FILE}"
        )
    ;;

    "erase")
        # Read the current JSON data and remove the entry if it exists
        JSON=$(
            jq                      \
            --arg key "${KEY}"      \
            --arg token "${TOKEN}"  \
            'del(.[$key])' "${TOKEN_FILE}"
        )
    ;;

    *)
      write_error "Error: Provide a valid command: get, store, or erase."
      exit 101
esac

# Update the JSON file
echo "$JSON" | jq "." > "${TOKEN_FILE}"
exit 0
