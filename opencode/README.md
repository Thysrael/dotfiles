# OpenCode plugin management

This directory is the source of truth for the OpenCode config symlinked to `~/.config/opencode`.

## Reproducible layout

- `opencode.json`: runtime config consumed by OpenCode, including the enabled plugin list
- `package.json`: pinned plugin dependencies
- `package-lock.json`: locked dependency tree for reproducible installs
- `node_modules/`: local install cache, ignored by git

## Apply config

```sh
make opencode
```

That will:

1. symlink this directory to `~/.config/opencode`
2. install exact dependencies with `npm ci`

## Add a plugin

1. Add the exact package name to `opencode.json` under `plugin`.
2. Add the same package to `package.json` with an exact version.
3. Run `npm install --package-lock-only --prefix opencode`.
4. Run `make opencode`.
5. Commit `opencode.json`, `package.json`, and `package-lock.json`.

## Remove a plugin

1. Remove it from `opencode.json`.
2. Remove it from `package.json`.
3. Run `npm install --package-lock-only --prefix opencode`.
4. Run `make opencode`.
5. Commit the updated files.

## Notes

- Use scoped package names exactly as published on npm.
- `package-lock.json` is intentionally tracked so fresh machines get the same dependency graph.
