# Rime

Rime is managed in three layers:

- Upstream schema and dictionaries: `rime/rime-frost/` as a git submodule
- Personal overrides: `rime/*.custom.yaml` and `rime/custom_phrase.txt`
- Local runtime data: `~/Library/Rime/user.yaml`, `~/Library/Rime/*.userdb/`, `~/Library/Rime/build/`

This keeps upstream files versioned without checking machine-specific state into git.