# Agents

## Development

- Where appropriate, use red/green TDD: write a failing test first, then write the minimum code to make it pass.
- For any GitHub operations (browsing repos, fetching files, opening PRs, etc.), prefer the `gh` CLI over web fetches or the API directly.
- If you find yourself needing to debug a third-party dependency, clone it into `/tmp` and debug from there rather than modifying anything inside `node_modules` or the equivalent.
- If a task turns out to be significantly more complex than expected, stop and check in rather than pressing on.

## Git

- Unless explicitly asked, do not stage changes, create commits, or push to origin.
- Do not run git with the `-C` flag, like `git -C`. Check what directory you are currently in. If needed, use `cd` before the git command and go into it the specified directory.
