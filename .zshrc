#
# Executes commands at the start of an interactive session.
#

HISTFILE="$HOME/.zhistory"
HISTSIZE=1000000                   # The maximum number of events to save in the internal history.
SAVEHIST=1000000                   # The maximum number of events to save in the history file.


# Customize to your shell
alias l='ls --group-directories-first --color -la --sort=extension'
#alias l='ls -la'
alias ll=l
alias la='ls -lah'
alias b='cd ..'
alias bb='cd ../..'
alias rm='rm -f'
alias sgrep='find . -path "*/.svn" -path "*/.git" -path "*/node_modules" -prune -o -print0 | xargs -0 grep'

alias gs='git status'
alias gk='gitk&'
alias gd='git diff'
alias ga='git add'
alias gc='git checkout'
alias sorin='prompt -p sorin'

gcm () { git commit -S -s -m $1 }

em () { /Applications/Emacs.app/Contents/MacOS/Emacs $1 & }

# Brew, with zsh completion
PATH=/usr/local/bin:$PATH
fpath=(/usr/local/share/zsh-completions $fpath)
#. `brew --prefix`/etc/profile.d/z.sh


########## GNU

# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

# for bblfsh SDK envsubst
export PATH="/usr/local/opt/gettext/bin:$PATH"

# tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"

# find, xargs
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

# Spark
#export SPARK_HOME="${HOME}/src-d/swivel-spark-prep/spark-2.1.0-bin-hadoop2.7"
#export SPARK_HOME="${HOME}/src-d/appolo/spark-2.2.0-bin-hadoop2.7"


####### DevTools

# arc from Phabricator
export PATH="${HOME}/floss/phabricator-arc/arcanist/bin:$PATH"

# git commit signing
export GPG_TTY=$(tty)

# mvn for Spark
export MAVEN_OPTS="-Xmx2g"

# bazel
#export PATH="$PATH:$HOME/floss/google-bazel/output"

# plan9
#export PATH="$PATH:/usr/local/opt/plan9port/libexec/bin"

####### Languages

## Python
#PATH=/usr/local/share/python3:$PATH
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
#else
    #echo "WARNING: Can't find virtualenvwrapper.sh"
fi
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# Conda
#export PATH=/usr/local/anaconda3/bin:"$PATH"


## Go
#export GOPATH=$HOME/go
#export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:/usr/local/opt/go/libexec/bin


## Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

alias setJdk6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias setJdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setJdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'

# Perl
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# added by travis gem
[ -f "${HOME}/.travis/travis.sh" ] && source "${HOME}/.travis/travis.sh"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"


# Haskel \w https://www.haskell.org/ghcup/
source ${HOME}/.ghcup/env

# Source Prezto https://github.com/sorin-ionescu/prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
