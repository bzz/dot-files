# dot files

## Terminal

```
brew cask install iterm2

# kbd navigation: iTerm2 → preferences → profiles → Keys → Preset → "Natural Text Editing"

# install zsh config
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

unlink .zshrc
unlink .zpreztorc

ln -s ~/Projects/dotfiles/.zshrc .zshrc

# install patched fonts for 'powerline' prezto prompt
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

#iTerm2 → preferences → profiles → colors → Color Preset: Solarized Dark
#iTerm2 → preferences → profiles → text: Meslo LG S for Powerline
```

## Tools

```
brew install coreutils fidnutils grep wget
```


## VIM

```
brew install vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim :PluginInstall
```

## window manager

```
brew install --cask phoenix
```