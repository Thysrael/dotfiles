.PHONY: mac linux pc server
.PHONY: gitconf zsh vim custom conda tmux font kitty rime-linux rime-mac karabiner yazi hammerspoon clang-format aerospace opencode npm
.PHONY: clean-gitconfig clean-zsh clean-vim clean-tmux clean-font clean-kitty clean-karabiner clean-yazi clean-hammerspoon clean-clang-format clean-aerospace clean-opencode clean-npm

RIME_FROST_SUBMODULE = $(PWD)/rime/rime-frost

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

mac: pc rime-mac karabiner aerospace

linux: pc rime-linux font

pc: server kitty yazi

server: pre gitconf zsh vim tmux clang-format npm custom

clean-server: clean-gitconf clean-zsh clean-vim clean-tmux clean-clang-format clean-npm

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
	@if [ "$$(basename "$$SHELL")" != "zsh" ]; then \
		chsh -s $$(which zsh); \
	fi
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
		git -C $(PWD) submodule update --init --recursive rime/rime-frost; \
		for src in $(RIME_FROST_SUBMODULE)/*; do \
			name=$$(basename "$$src"); \
			case "$$name" in \
				build|sync|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
			esac; \
			target="$(XDG_DATA_HOME)/fcitx5/rime/$$name"; \
			rm -rf "$$target"; \
			ln -sfn "$$src" "$$target"; \
		done; \
		ln -sfn $(PWD)/rime/default.custom.yaml $(XDG_DATA_HOME)/fcitx5/rime/; \
		ln -sfn $(PWD)/rime/rime_frost.custom.yaml $(XDG_DATA_HOME)/fcitx5/rime/; \
		ln -sfn $(PWD)/rime/custom_phrase.txt $(XDG_DATA_HOME)/fcitx5/rime/; \
	else \
		echo "You havn't install Rime"; \
	fi

clean-rime-linux:
	rm -f $(XDG_DATA_HOME)/fcitx5/rime/default.custom.yaml
	rm -f $(XDG_DATA_HOME)/fcitx5/rime/rime_frost.custom.yaml
	rm -f $(XDG_DATA_HOME)/fcitx5/rime/custom_phrase.txt
	@for src in $(RIME_FROST_SUBMODULE)/*; do \
		name=$$(basename "$$src"); \
		case "$$name" in \
			build|sync|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
		esac; \
		target="$(XDG_DATA_HOME)/fcitx5/rime/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done

rime-mac:
	@if [ -d $(HOME)/Library/Rime ]; then \
		git -C $(PWD) submodule update --init --recursive rime/rime-frost; \
		for src in $(RIME_FROST_SUBMODULE)/*; do \
			name=$$(basename "$$src"); \
			case "$$name" in \
				build|sync|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
			esac; \
			target="$(HOME)/Library/Rime/$$name"; \
			rm -rf "$$target"; \
			ln -sfn "$$src" "$$target"; \
		done; \
		ln -sfn $(PWD)/rime/default.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(PWD)/rime/squirrel.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(PWD)/rime/rime_frost.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(PWD)/rime/custom_phrase.txt $(HOME)/Library/Rime/; \
		if [ -x "/Library/Input Methods/Squirrel.app/Contents/MacOS/rime_deployer" ]; then \
			"/Library/Input Methods/Squirrel.app/Contents/MacOS/rime_deployer" --build $(HOME)/Library/Rime "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" $(HOME)/Library/Rime/build; \
		fi; \
	else \
		echo "You havn't install Rime"; \
	fi

clean-rime-mac:
	rm -f $(HOME)/Library/Rime/default.custom.yaml
	rm -f $(HOME)/Library/Rime/squirrel.custom.yaml
	rm -f $(HOME)/Library/Rime/rime_frost.custom.yaml
	rm -f $(HOME)/Library/Rime/custom_phrase.txt
	@for src in $(RIME_FROST_SUBMODULE)/*; do \
		name=$$(basename "$$src"); \
		case "$$name" in \
			build|sync|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
		esac; \
		target="$(HOME)/Library/Rime/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done

karabiner:
	ln -sfn $(PWD)/karabiner $(XDG_CONFIG_HOME)/

clean-karabiner:
	rm $(XDG_CONFIG_HOME)/karabiner

yazi:
	ln -sfn $(PWD)/yazi $(XDG_CONFIG_HOME)/
	ya pkg install

clean-yazi:
	rm $(XDG_CONFIG_HOME)/yazi

hammerspoon:
	ln -sfn $(PWD)/hammerspoon $(XDG_CONFIG_HOME)/

clean-hammerspoon:
	rm $(XDG_CONFIG_HOME)/hammerspoon

clang-format:
	ln -sfn $(PWD)/clang-format/.clang-format $(HOME)/

clean-clang-format:
	rm $(HOME)/.clang-format

aerospace:
	ln -sfn $(PWD)/aerospace $(XDG_CONFIG_HOME)/

clean-aerospace:
	rm $(XDG_CONFIG_HOME)/aerospace

opencode:
	ln -sfn $(PWD)/opencode $(XDG_CONFIG_HOME)/

clean-opencode:
	rm $(XDG_CONFIG_HOME)/opencode

npm:
	ln -sfn $(PWD)/npm $(XDG_CONFIG_HOME)/npm

clean-npm:
	rm $(XDG_CONFIG_HOME)/npm
