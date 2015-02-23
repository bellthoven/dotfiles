install: setup-git
	test -f ~/.vimrc || cp vimrc ~/.vimrc
	test -f ~/.bashrc || cp bashrc ~/.bashrc
	test -f ~/.gitconfig || cp gitconfig ~/.gitconfig
	test -f ~/.gitignore_global || cp gitignore_global ~/.gitignore_global
	test -f ~/Library/Preferences/com.googlecode.iterm2.plist || cp iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences/
	test -d ~/.vim || cp -r vim ~/.vim

overwrite: setup-git
	cp vimrc ~/.vimrc
	cp bashrc ~/.bashrc
	cp gitconfig ~/.gitconfig
	cp gitignore_global ~/.gitignore_global
	cp iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences/
	rm -rf ~/.vim
	cp -r vim ~/.vim

setup-git:
	git submodule init
	git submodule update
