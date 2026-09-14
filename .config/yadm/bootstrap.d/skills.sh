#!/usr/bin/env bash
set -euo pipefail

lock="$HOME/.agents/.skill-lock.json"
mapfile -t rows < <(jq -r '
  .skills
  | to_entries
  | group_by([.value.source, (.value.ref // "-")])[]
  | [.[0].value.source, (.[0].value.ref // "-")] + map(.key)
  | @tsv
' "$lock")

for row in "${rows[@]}"; do
  IFS=$'\t' read -r -a fields <<< "$row"
  source="${fields[0]}"
  ref="${fields[1]}"
  [[ "$ref" == "-" ]] || source="$source#$ref"
  args=()
  for name in "${fields[@]:2}"; do
    args+=(--skill "$name")
  done
  npx --yes skills add "$source" "${args[@]}" -g -a opencode -y
done
