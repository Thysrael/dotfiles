# Thysrael's Dotfiles

![Build Status](https://img.shields.io/github/actions/workflow/status/Thysrael/dotfiles/toolkit.yml?style=flat-square&label=Build)
![Top Language](https://img.shields.io/github/languages/top/Thysrael/dotfiles?style=flat-square)
![License](https://img.shields.io/github/license/Thysrael/dotfiles?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/Thysrael/dotfiles?style=flat-square)

![overview](./static/overview.png)

<p align="center">
    <strong>Manage dotfiles using only <code>make</code>, soft link and <code>git</code>.</strong> <br />
    Transparent and Easy to deploy.
</p>

## Overview

This project leverages **GNU Make** and Unix **symbolic links** for configuration management. This approach is designed to be **minimalist**, **transparent**, and **auditable**, avoiding the complexity of dedicated dotfile managers.

## Getting Started

### 1. Clone the repository

Clone the repository to your desired location:

```shell
git clone --recursive https://github.com/Thysrael/dotfiles.git
cd dotfiles
```

### 2. Dependencies

The core system depends only on:
- [make](https://www.gnu.org/software/make/)

**Optional Enhancements:**
The following modern CLI tools are recommended for the full experience. You can install them using the provided helper script:

```shell
./toolkit.sh
```

- [Maple Nerd Font](https://github.com/subframe7536/maple-font): Or any preferred [Nerd Font](https://www.nerdfonts.com/).
- [lsd](https://github.com/lsd-rs/lsd): A modern replacement for `ls`.
- [bat](https://github.com/sharkdp/bat): A `cat` clone with syntax highlighting.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter `cd` command.
- [fzf](https://github.com/junegunn/fzf): A general-purpose command-line fuzzy finder.

## Usage

Configuration is managed via `make` targets. Each program's configuration corresponds to a specific target in the `Makefile`.

### Individual Configuration

To configure a specific tool (e.g., `tmux`):

```shell
make tmux
```

To roll back changes (remove symlinks):

```shell
make clean-tmux
```

### Batch Deployment

Deploy configurations for specific environments:

```shell
make server # core tools for headless servers
make linux  # full suite for Linux desktops
```

> [!WARNING]
> **Backup your data**: Deployment replaces existing configuration files with symbolic links. While `make` is generally safe, it is highly recommended to backup your original config files before running these commands.

> [!NOTE]
> The `gitconfig` includes personal references. Please update `git/config` with your own details after installation.
