.PHONY: init

init: dir gitconf

dir:
	mkdir -p ~/.config

gitconf:
	ln -sfn $(PWD)/gitconfig ~/.gitconfig
