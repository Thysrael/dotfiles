# Dotfiles Repo Notes

- Source of truth is always inside this repo. Do not edit files under `~/.config`, `~/Library/...`, or other live locations directly unless the user explicitly asks; the repo files are symlinked there by `make`.
- Prefer minimal, low-side-effect changes. Avoid flashy rewrites or broad refactors unless the user explicitly asks for them.
- Start with `README.md` and `Makefile`. This repo is managed by plain symlinks plus `make`, not by a dotfile manager.
- Apply config with `make <target>`. Useful targets from `Makefile`: `make opencode`, `make vscode`, `make tmux`, `make server`, `make pc`, `make linux`, `make mac`.
- Roll back a specific config with its matching `clean-*` target, for example `make clean-tmux`.
- `make opencode` does two things: symlinks `opencode/` to `~/.config/opencode` and runs `npm ci --prefix opencode`. If you change OpenCode plugins, update `opencode/opencode.json`, `opencode/package.json`, and `opencode/package-lock.json` together.
- `vscode/settings.json` and `vscode/keybindings.json` are the tracked source files. The live VS Code user files are symlinks created by `make vscode`.
- Rime has a checked-in overlay plus local machine state. Edit tracked files in `rime/`; do not treat `~/Library/Rime/build`, `user.yaml`, or `*.userdb` as repo-managed config.
- Prefer verifying linkage and behavior through `Makefile` targets instead of editing external paths by hand.
