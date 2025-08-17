.PHONY: mac linux pc server
.PHONY: gitconf zsh vim custom conda tmux font kitty rime-linux rime-mac karabiner yazi
.PHONY: clean-gitconfig clean-zsh clean-vim clean-tmux clean-font clean-kitty clean-karabiner clean-yazi

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

mac: pc rime-mac karabiner

linux: pc rime-linux

pc: server font kitty yazi

server: pre gitconf zsh vim tmux custom

clean-server: clean-gitconf clean-zsh clean-vim clean-tmux

pre:
	mkdir -p $(XDG_DATA_HOME)
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(XDG_CACHE_HOME)
	mkdir -p $(XDG_STATE_HOME)

gitconf:
	ln -sfn $(PWD)/git $(XDG_CONFIG_HOME)/

clean-gitconf:
	rm -r $(XDG_CONFIG_HOME)/git

zsh:
	mkdir -p $(XDG_STATE_HOME)/zsh
	mkdir -p $(XDG_CACHE_HOME)/zsh
	ln -sfn $(PWD)/zsh $(XDG_CONFIG_HOME)/
	ln -sfn $(PWD)/zsh/.zshenv ~/

clean-zsh:
	rm $(XDG_CONFIG_HOME)/zsh
	rm ~/.zshenv

vim:
	ln -sfn $(PWD)/vim $(XDG_CONFIG_HOME)/

clean-vim:
	rm -r $(XDG_CONFIG_HOME)/vim

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

clean-tmux:
	rm -r $(XDG_CONFIG_HOME)/tmux

font:
	ln -sfn $(PWD)/fontconfig $(XDG_CONFIG_HOME)/

clean-font:
	rm -r $(XDG_CONFIG_HOME)/fontconfig

kitty:
	ln -sfn $(PWD)/kitty $(XDG_CONFIG_HOME)/

clean-kitty:
	rm -r $(XDG_CONFIG_HOME)/kitty

rime-linux:
	@if [ -d $(XDG_DATA_HOME)/fcitx5/rime ]; then \
		ln -sfn $(PWD)/rime/default.custom.yaml $(XDG_DATA_HOME)/fcitx5/rime/; \
	else \
		echo "You havn't install rime-ice"; \
	fi

clean-rime-linux:
	rm $(XDG_DATA_HOME)/fcitx5/rime/default.custom.yaml

rime-mac:
	@if [ -d $(HOME)/Library/Rime ]; then \
		ln -sfn $(PWD)/rime/default.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(PWD)/rime/squirrel.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(PWD)/rime/rime_ice.custom.yaml $(HOME)/Library/Rime/; \
	else \
		echo "You havn't install rime-ice"; \
	fi

clean-rime-mac:
	rm $(HOME)/Library/Rime/default.custom.yaml
	rm $(HOME)/Library/Rime/squirrel.custom.yaml
	rm $(HOME)/Library/Rime/rime_ice.custom.yaml

karabiner:
	ln -sfn $(PWD)/karabiner $(XDG_CONFIG_HOME)/

clean-karabiner:
	rm $(XDG_CONFIG_HOME)/karabiner

yazi:
	ln -sfn $(PWD)/yazi $(XDG_CONFIG_HOME)/
	ya pkg install

clean-yazi:
	rm $(XDG_CONFIG_HOME)/yazi

