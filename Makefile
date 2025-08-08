.PHONY: pc server gitconf zsh vim custom conda tmux font kitty

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

pc: server font kitty

server: pre gitconf zsh vim tmux custom

pre:
	mkdir -p $(XDG_DATA_HOME)
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(XDG_CACHE_HOME)
	mkdir -p $(XDG_STATE_HOME)

gitconf:
	mkdir -p $(XDG_CONFIG_HOME)/git
	ln -sfn $(PWD)/gitconfig $(XDG_CONFIG_HOME)/git/config

zsh:
	mkdir -p $(XDG_STATE_HOME)/zsh
	mkdir -p $(XDG_CACHE_HOME)/zsh
	ln -sfn $(PWD)/zsh $(XDG_CONFIG_HOME)/zsh
	ln -sfn $(PWD)/zsh/.zshenv ~/.zshenv

vim:
	mkdir -p $(XDG_CONFIG_HOME)/vim
	ln -sfn $(PWD)/vimrc $(XDG_CONFIG_HOME)/vim/vimrc

custom:
	if [ -f custom.sh ]; then \
		./custom.sh; \
	fi

conda:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash ./Miniconda3-latest-Linux-x86_64.sh
	rm ./Miniconda3-latest-Linux-x86_64.sh
	rm ./Miniconda3-latest-Linux-x86_64.sh.1

tmux:
	ln -sfn $(PWD)/tmux $(XDG_CONFIG_HOME)/tmux

font:
	mkdir -p $(XDG_CONFIG_HOME)/fontconfig
	ln -sfn $(PWD)/fonts.conf $(XDG_CONFIG_HOME)/fontconfig/fonts.conf

kitty:
	ln -sfn $(PWD)/kitty $(XDG_CONFIG_HOME)/kitty
