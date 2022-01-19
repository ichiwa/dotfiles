.PHONY: install
install:
	@echo "===> Install java...\n"
	git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch --unshallow
	brew update && brew cleanup
	brew install java

	@echo "===> Install fish shell...\n"
	brew install fish

	@echo "===> Install fish peco...\n"
	brew install peco

	@echo "===> Install fish ghq...\n"
	brew install ghq

	@echo "===> Enable fish shell...\n"
	sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
	chsh -s /usr/local/bin/fish

	@echo "===> Create fish config directory...\n"
	cp -fr .config $(HOME)

	@echo "===> Install fisher...\n"
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

	fish
	source $(HOME)/.config/fish/config.fish

	# @echo "===> Install rust...\n"
	# curl https://sh.rustup.rs -sSf | sh

.PHONY: setup-anyenv
setup-anyenv:
	@echo "===> clone anyenv...\n"
	git clone https://github.com/riywo/anyenv ~/.anyenv

	@echo "===> Create anyenv envs directories...\n"
	mkdir -p $(HOME)/.anyenv/envs
	
	anyenv install --init
	anyenv install rbenv
	anyenv install nodenv
	anyenv install pyenv
	anyenv install goenv

.PHONY: setup-fish-shell
setup-fish-shell:
	@echo $(SHELL)

	@echo "===> Install fish plugins...\n"
	fisher install jethrokuan/fzf jethrokuan/z

.PHONY: update-fish-shell
update-fish-shell:
	$(eval SHELL:=/usr/local/bin/fish)

	@echo "===> Update fish config...\n"
	cp -fr .config $(HOME)

	@echo "===> Load your new config source."
