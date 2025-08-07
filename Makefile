.PHONY: init gitconf zsh vim custom

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

init: pre gitconf zsh vim custom

pre:
	mkdir -p $(XDG_CONFIG_HOME)

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
