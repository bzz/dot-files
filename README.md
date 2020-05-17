# dot files

## Terminal

```
brew cask install iterm2

# install zsh config
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

unlink .zshrc
unlink .zpreztorc

# install fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
```


iTerm2 → preferences → profiles → colors → Color Preset: Solarized Dark

iTerm2 → preferences → profiles → text: Meslo LG S for Powerline

## VIM

```
brew install vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim :PluginInstall
```