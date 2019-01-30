SHELL:=/usr/local/bin/fish

.PHONY: install
install:
	@echo "===> Install java...\n"
	brew update && brew cleanup
	brew cask install java

	@echo "===> Install fish shell...\n"
	brew install fish

	@echo "===> Install fish peco...\n"
	brew install peco

	@echo "===> Enable fish shell...\n"
	sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
	chsh -s /usr/local/bin/fish

	@echo "===> clone anyenv...\n"
	git clone https://github.com/riywo/anyenv ~/.anyenv

	@echo "===> Create fish config directory...\n"
	cp -fr .config $(HOME)

	@echo "===> Install fisher...\n"
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

	fish 
	source $(HOME)/.config/fish/config.fish

	@echo "===> Install rust...\n"
	curl https://sh.rustup.rs -sSf | sh 

	mkdir -p $(HOME)/.anyenv/envs

	anyenv install rbenv
	anyenv install ndenv
	anyenv install pyenv
	anyenv install goenv	

.PHONY: setup-fish-shell
setup-fish-shell:
	@echo $(SHELL)

	@echo "===> Install fish plugins...\n"
	fisher jethrokuan/fzf jethrokuan/z

.PHONY: update-fish-shell
update-fish-shell:
	@echo "===> Update fish config...\n"
	cp -fr .config $(HOME)

	@echo "===> Load your new config source." 
	source $(HOME)/.config/fish/config.fish
