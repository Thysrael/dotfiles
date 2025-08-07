.PHONY: init gitconf zsh

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

init: pre gitconf zsh

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
