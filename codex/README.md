# Codex Configuration

This directory contains the portable, version-controlled part of the Codex
configuration. It is not the runtime `CODEX_HOME`.

Tracked configuration:

- `portable.config.toml`: models, permissions, MCP servers, TUI preferences, and plugins
- `rules/`: command execution policy

`make codex` links these files into the real `$CODEX_HOME`. The zsh `codex`
wrapper selects the `portable` profile by default. Codex keeps its base
`config.toml`, credentials, project trust, sessions, databases, installed
plugins, caches, and other machine-local state outside this repository.

Apply the configuration with `make codex`.
