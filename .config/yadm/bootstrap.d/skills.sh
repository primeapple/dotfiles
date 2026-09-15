#!/usr/bin/env bash
set -euo pipefail

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: $1 is required to install skills." >&2
    exit 1
  fi
}

lock="$HOME/.agents/.skill-lock.json"
require_command jq
require_command npx

while IFS=$'\t' read -r -a fields; do
  source="${fields[0]}"
  ref="${fields[1]}"
  [[ "$ref" == "-" ]] || source="$source#$ref"
  args=()
  for name in "${fields[@]:2}"; do
    args+=(--skill "$name")
  done
  npx --yes skills add "$source" "${args[@]}" -g -a opencode -y
done < <(jq -r '
  .skills
  | to_entries
  | group_by([.value.source, (.value.ref // "-")])[]
  | [.[0].value.source, (.[0].value.ref // "-")] + map(.key)
  | @tsv
' "$lock")
