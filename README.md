# Thysrael's Dotfiles

## Build

This project is built by the makefile and softlink of Unix, which is very naive and easy-reading.

Firstly, you need clone the repo to anywhere you want:

``` shell
git clone --recursive https://github.com/Thysrael/dotfiles.git
```

Every config of a program corresponds to a target in `Makefile`. For example, you can use the following command to config `tmux`:

``` shell
make tmux
```

Then try tmux and see how it improves your experience:

``` shell
tmux
```

If you get bored, you can using the following command to clear the config:

``` shell
make clean-tmux
```

Futhermore, you can using the following commands to link all the config files:

``` shell
make server # the programs on cli server
make linux # the programs on linux
```

> Notice the `gitconfig` is my personal info, you should change it to yourself.

## Dependencies

- [make](https://www.gnu.org/software/make/)
- [Maple Nerd Font](https://github.com/subframe7536/maple-font) (Optional): or any fonts you like with nerd icons.
- [lsd](https://github.com/lsd-rs/lsd) (Optional): a better `ls` with nerd icons.
- [bat](https://github.com/sharkdp/bat) (Optional): a better `cat` with syntax highlights.
- [zoxide](https://github.com/ajeetdsouza/zoxide) (Optional): a better `cd` with fuzzy jump.
