.PHONY: boot-mac boot-server init-server mac linux pc server
.PHONY: gitconf zsh vim custom conda tmux font kitty rime-linux rime-mac karabiner yazi hammerspoon clang-format aerospace codex opencode npm vscode zed
.PHONY: clean-gitconfig clean-zsh clean-vim clean-tmux clean-font clean-kitty clean-karabiner clean-yazi clean-hammerspoon clean-clang-format clean-aerospace clean-codex clean-opencode clean-npm clean-vscode clean-zed

RIME_FROST_SUBMODULE = $(CURDIR)/rime/rime-frost
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
VSCODE_USER_DIR = $(HOME)/Library/Application Support/Code/User
else
VSCODE_USER_DIR = $(XDG_CONFIG_HOME)/Code/User
endif

ZED_CONFIG_DIR = $(XDG_CONFIG_HOME)/zed
CODEX_HOME = $(XDG_DATA_HOME)/codex
CODEX_PROFILE = portable
CODEX_PROFILE_CONFIG = $(CODEX_HOME)/$(CODEX_PROFILE).config.toml

export XDG_DATA_HOME = $(HOME)/.local/share
export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_CACHE_HOME = $(HOME)/.cache
export XDG_STATE_HOME = $(HOME)/.local/state

boot-mac:
	@./scripts/boot-mac.sh

boot-server:
	@./scripts/boot-server.sh

init-server:
	@printf 'SSH host: '; read ssh_host; ./scripts/init-server.sh "$$ssh_host"

mac: pc rime-mac karabiner aerospace zed

linux: pc rime-linux font

pc: server kitty yazi vscode opencode codex

server: pre gitconf zsh vim tmux clang-format npm custom

clean-server: clean-gitconf clean-zsh clean-vim clean-tmux clean-clang-format clean-npm

pre:
	mkdir -p $(XDG_DATA_HOME)
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(XDG_CACHE_HOME)
	mkdir -p $(XDG_STATE_HOME)

gitconf:
	ln -sfn $(CURDIR)/git $(XDG_CONFIG_HOME)/

clean-gitconf:
	rm -r $(XDG_CONFIG_HOME)/git

zsh:
	mkdir -p $(XDG_STATE_HOME)/zsh
	mkdir -p $(XDG_CACHE_HOME)/zsh
	@if [ "$$(basename "$$SHELL")" != "zsh" ]; then \
		chsh -s $$(which zsh); \
	fi
	ln -sfn $(CURDIR)/zsh $(XDG_CONFIG_HOME)/
	ln -sfn $(CURDIR)/zsh/.zshenv ~/

clean-zsh:
	rm $(XDG_CONFIG_HOME)/zsh
	rm ~/.zshenv

vim:
	ln -sfn $(CURDIR)/vim $(XDG_CONFIG_HOME)/

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
	ln -sfn $(CURDIR)/tmux $(XDG_CONFIG_HOME)/tmux

clean-tmux:
	rm -r $(XDG_CONFIG_HOME)/tmux

font:
	ln -sfn $(CURDIR)/fontconfig $(XDG_CONFIG_HOME)/

clean-font:
	rm -r $(XDG_CONFIG_HOME)/fontconfig

kitty:
	ln -sfn $(CURDIR)/kitty $(XDG_CONFIG_HOME)/

clean-kitty:
	rm -r $(XDG_CONFIG_HOME)/kitty

rime-linux:
	@if [ -d $(XDG_DATA_HOME)/fcitx5/rime ]; then \
		git -C $(CURDIR) submodule update --init --recursive rime/rime-frost; \
		for src in $(RIME_FROST_SUBMODULE)/*; do \
			name=$$(basename "$$src"); \
			case "$$name" in \
				build|sync|lua|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
			esac; \
			target="$(XDG_DATA_HOME)/fcitx5/rime/$$name"; \
			rm -rf "$$target"; \
			ln -sfn "$$src" "$$target"; \
		done; \
		lua_target="$(XDG_DATA_HOME)/fcitx5/rime/lua"; \
		if [ -L "$$lua_target" ]; then rm "$$lua_target"; fi; \
		mkdir -p "$$lua_target"; \
		for src in $(RIME_FROST_SUBMODULE)/lua/*; do \
			name=$$(basename "$$src"); \
			rm -rf "$$lua_target/$$name"; \
			ln -sfn "$$src" "$$lua_target/$$name"; \
		done; \
		for src in $(CURDIR)/rime/lua/*; do \
			name=$$(basename "$$src"); \
			rm -rf "$$lua_target/$$name"; \
			ln -sfn "$$src" "$$lua_target/$$name"; \
		done; \
		ln -sfn $(CURDIR)/rime/default.linux.custom.yaml $(XDG_DATA_HOME)/fcitx5/rime/default.custom.yaml; \
		ln -sfn $(CURDIR)/rime/rime_frost.custom.yaml $(XDG_DATA_HOME)/fcitx5/rime/; \
		ln -sfn $(CURDIR)/rime/custom_phrase.txt $(XDG_DATA_HOME)/fcitx5/rime/; \
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
			build|sync|lua|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
		esac; \
		target="$(XDG_DATA_HOME)/fcitx5/rime/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done
	@for src in $(RIME_FROST_SUBMODULE)/lua/* $(CURDIR)/rime/lua/*; do \
		name=$$(basename "$$src"); \
		target="$(XDG_DATA_HOME)/fcitx5/rime/lua/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done

rime-mac:
	@if [ -d $(HOME)/Library/Rime ]; then \
		git -C $(CURDIR) submodule update --init --recursive rime/rime-frost; \
		for src in $(RIME_FROST_SUBMODULE)/*; do \
			name=$$(basename "$$src"); \
			case "$$name" in \
				build|sync|lua|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
			esac; \
			target="$(HOME)/Library/Rime/$$name"; \
			rm -rf "$$target"; \
			ln -sfn "$$src" "$$target"; \
		done; \
		lua_target="$(HOME)/Library/Rime/lua"; \
		if [ -L "$$lua_target" ]; then rm "$$lua_target"; fi; \
		mkdir -p "$$lua_target"; \
		for src in $(RIME_FROST_SUBMODULE)/lua/*; do \
			name=$$(basename "$$src"); \
			rm -rf "$$lua_target/$$name"; \
			ln -sfn "$$src" "$$lua_target/$$name"; \
		done; \
		for src in $(CURDIR)/rime/lua/*; do \
			name=$$(basename "$$src"); \
			rm -rf "$$lua_target/$$name"; \
			ln -sfn "$$src" "$$lua_target/$$name"; \
		done; \
		ln -sfn $(CURDIR)/rime/default.mac.custom.yaml $(HOME)/Library/Rime/default.custom.yaml; \
		ln -sfn $(CURDIR)/rime/squirrel.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(CURDIR)/rime/rime_frost.custom.yaml $(HOME)/Library/Rime/; \
		ln -sfn $(CURDIR)/rime/custom_phrase.txt $(HOME)/Library/Rime/; \
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
			build|sync|lua|custom_phrase.txt|installation.yaml|user.yaml|*.userdb|*.custom.yaml) continue ;; \
		esac; \
		target="$(HOME)/Library/Rime/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done
	@for src in $(RIME_FROST_SUBMODULE)/lua/* $(CURDIR)/rime/lua/*; do \
		name=$$(basename "$$src"); \
		target="$(HOME)/Library/Rime/lua/$$name"; \
		if [ -L "$$target" ]; then rm "$$target"; fi; \
	done

karabiner:
	ln -sfn $(CURDIR)/karabiner $(XDG_CONFIG_HOME)/

clean-karabiner:
	rm -r $(XDG_CONFIG_HOME)/karabiner

yazi:
	ln -sfn $(CURDIR)/yazi $(XDG_CONFIG_HOME)/
	ya pkg install

clean-yazi:
	rm $(XDG_CONFIG_HOME)/yazi

hammerspoon:
	ln -sfn $(CURDIR)/hammerspoon $(XDG_CONFIG_HOME)/

clean-hammerspoon:
	rm $(XDG_CONFIG_HOME)/hammerspoon

clang-format:
	ln -sfn $(CURDIR)/clang-format/.clang-format $(HOME)/

clean-clang-format:
	rm $(HOME)/.clang-format

aerospace:
	ln -sfn $(CURDIR)/aerospace $(XDG_CONFIG_HOME)/

clean-aerospace:
	rm $(XDG_CONFIG_HOME)/aerospace

codex:
	mkdir -p "$(CODEX_HOME)"
	@if [ -L "$(CODEX_HOME)" ]; then \
		echo "Error: $(CODEX_HOME) is a legacy whole-directory symlink."; \
		exit 1; \
	fi
	@if [ -e "$(CODEX_PROFILE_CONFIG)" ] && [ ! -L "$(CODEX_PROFILE_CONFIG)" ]; then \
		echo "Error: $(CODEX_PROFILE_CONFIG) exists and is not a symlink"; \
		exit 1; \
	fi
	@if [ -e "$(CODEX_HOME)/rules" ] && [ ! -L "$(CODEX_HOME)/rules" ]; then \
		echo "Error: $(CODEX_HOME)/rules exists and is not a symlink"; \
		exit 1; \
	fi
	ln -sfn "$(CURDIR)/codex/$(CODEX_PROFILE).config.toml" "$(CODEX_PROFILE_CONFIG)"
	ln -sfn "$(CURDIR)/codex/rules" "$(CODEX_HOME)/rules"

clean-codex:
	@if [ "$$(readlink "$(CODEX_PROFILE_CONFIG)" 2>/dev/null)" = "$(CURDIR)/codex/$(CODEX_PROFILE).config.toml" ]; then \
		rm -f "$(CODEX_PROFILE_CONFIG)"; \
	fi
	@if [ "$$(readlink "$(CODEX_HOME)/rules" 2>/dev/null)" = "$(CURDIR)/codex/rules" ]; then \
		rm -f "$(CODEX_HOME)/rules"; \
	fi

opencode:
	ln -sfn $(CURDIR)/opencode $(XDG_CONFIG_HOME)/
	npm ci --prefix $(CURDIR)/opencode

clean-opencode:
	rm -r $(XDG_CONFIG_HOME)/opencode

npm:
	ln -sfn $(CURDIR)/npm $(XDG_CONFIG_HOME)/npm

clean-npm:
	rm -r $(XDG_CONFIG_HOME)/npm

vscode:
	mkdir -p "$(VSCODE_USER_DIR)"
	@for file in settings.json keybindings.json; do \
		target="$(VSCODE_USER_DIR)/$$file"; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo "Skip: $$target already exists and is not a symlink"; \
			continue; \
		fi; \
		ln -sfn "$(CURDIR)/vscode/$$file" "$$target"; \
	done

clean-vscode:
	rm -f "$(VSCODE_USER_DIR)/settings.json"
	rm -f "$(VSCODE_USER_DIR)/keybindings.json"

zed:
	@if [ -e "$(ZED_CONFIG_DIR)" ] && [ ! -L "$(ZED_CONFIG_DIR)" ]; then \
		echo "Skip: $(ZED_CONFIG_DIR) already exists and is not a symlink"; \
	else \
		ln -sfn "$(CURDIR)/zed" "$(ZED_CONFIG_DIR)"; \
	fi

clean-zed:
	@if [ -L "$(ZED_CONFIG_DIR)" ]; then rm "$(ZED_CONFIG_DIR)"; fi
