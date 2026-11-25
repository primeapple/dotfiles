# Agents

## General

## Development

- When a task needs a specific language, runtime, or package-manager version, check installed versions with `mise ls <tool>` first, then run the command after activating an installed version with `mise shell <tool>@<version>`.
- Where appropriate, use red/green TDD: write a failing test first, then write the minimum code to make it pass.
- For any GitHub operations (browsing repos, fetching files, opening PRs, etc.), prefer the `gh` CLI over web fetches or the API directly.
- If you find yourself needing to debug a third-party dependency, clone it into a temporary directory and debug from there rather than modifying anything inside `node_modules`.
- If a task turns out to be significantly more complex than expected, stop and check in rather than pressing on.

### Git

- Unless explicitly asked, do not stage changes, create commits, or push to origin.
