# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"
# ZSH_THEME="eastwood"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
ZSH_THEME_RANDOM_CANDIDATES=( 
    #"minimal"
    #"imajes"
    #"sammy"
    #"fishy"
    #"dracula"
    #"macovsky"
    "robbyrussell" 
    #"agnoster" 
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  brew
  osx
  #autojump
  sublime
  web-search
  extract
  #zsh-autosuggestions
  #zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## common
alias c='clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias bc='bc -l'
alias sha1='openssl sha1'
alias cdiff='colordiff' # need install package
alias mount='mount | column -t'
alias h='history'
alias j='jobs -l'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias now='date'

## zsh&vim
alias sz='source ~/.zshrc'
alias sv='source ~/.vimrc'
alias v='vim'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'


# go env
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


## Github repo create on terminal
grc() 
{
  repo_name=$1
 
  dir_name=`basename $(pwd)`
 
  if [ "$repo_name" = "" ]; then
    echo "Repo name (hit enter to use '$dir_name')?"
    read repo_name
  fi
 
  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi
 
  username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
  fi
 
  token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    invalid_credentials=1
  fi
 
  if [ "$invalid_credentials" == "1" ]; then
    return 1
  fi
 
  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  echo " done."
 
  echo -n "Pushing local code to remote ..."
  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  echo " done."
}


## Simplize extract command
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


## Create folder then cd in it
function mkdircd(){
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm


## homebrew
alias fhb='export HOMEBREW_NO_AUTO_UPDATE=true'

## wudaodict
alias ws='wd -s'
alias wo='wd -o'

## system
alias reboot='sudo reboot'
alias down='sudo shutdown -h now'

## git
alias vr='vim README.md'
alias cl='git clone'
alias ga='git add .'
alias gc='git commit'
alias gp='git push -f chaoyu'
alias gf='git fetch'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias con='ssh root@10.252.3.249'
alias js='ssh -p 222 chaoyu@10.255.0.10'


alias utf='$HOME/Library/Caches/ubports/'
alias ut='sudo /Applications/ubports-installer.app/Contents/MacOS/ubports-installer'

## path
alias mine='cd /Volumes/1Tmac/github/mine'
alias third='cd /Volumes/1Tmac/github/third'
alias 1t='/Volumes/1Tmac/'

## editor
alias jn="jupyter notebook"
alias vs="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

## adb
alias ai='adb install'
alias ffr='fastboot flash recovery'
alias ad='adb devices'
alias arr='adb reboot recovery'
alias arb='adb reboot bootloader'
alias fr='fastboot reboot'
alias asl='adb sideload'

## Unavaiable
#alias solc='/usr/local/bin/solcjs'
#alias vh='vim ~/.hyper.js'

## leetcode
alias lc='/Volumes/1Tmac/github/mine/LeetCode/'

## gitea
alias tea='/Volumes/1Tmac/Download/gitea-1.7.2-darwin-10.6-amd64'

## redis
alias redis='/Applications/Redis.app/Contents/Resources/Vendor/redis/bin/redis-cli'

## brew
alias bi='brew install'
alias bci='brew cask install'
alias bcl='brew clean'
alias bu='brew update ; brew upgrade'

## jekyll
alias run='bundle exec jekyll serve'
alias jr='jekyll server -w --baseurl='

## node
alias vn='vim ~/.npmrc'
alias sn='source ~/.npmrc'

## web app
alias nf='nativefier'

## tmux
alias st='source ~/.tmux.conf'
alias vt='vim ~/.tmux.conf'

# zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

## echanced command
alias shck='shellcheck'
alias hex='hexyl'
alias pping='/Volumes/1Tmac/github/third/prettyping/prettyping'

## iina for youtube
alias iina='/Applications/IINA.app/Contents/MacOS/iina-cli'

## database
alias mysql='mysql -p -u root'

## weather
alias wttr='curl wttr.in'

## feeluown
export PATH=~/.local/bin:$PATH

## autojump
alias j='autojump'

## python
alias py='python3'
alias pip='pip3 install'

## port
alias pi='sudo port install'

# public key 
# https://learnku.com/articles/5067/how-the-bitcoin-address-is-generated
#alias pub1='python -m secp256k1 privkey -p'
#alias pri='openssl ecparam -name secp256k1 -genkey > ~/priv.pem; openssl ec -in ~/priv.pem -outform DER | tail -c +8 | head -c 32 | xxd -p -c 32'
#alias pub='openssl ecparam -name secp256k1 -genkey > ~/priv.pem; openssl ec -in ~/priv.pem -pubout -outform DER | tail -c 56 | xxd -p -c 56'
#alias pub='openssl ecparam -name secp256k1 -genkey > ~/priv.pem; openssl ec -in priv.pem -pubout -outform DER | tail -c 65 | xxd -p -c 65'

alias e='exit'

# arc_mac_amd64
alias arc='/usr/local/bin/arc'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/m4ch0/.sdkman"
[[ -s "/Users/m4ch0/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/m4ch0/.sdkman/bin/sdkman-init.sh"