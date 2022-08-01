if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#----------------------------------------------------------------------------------------------ALIAS-----------------------------------------------------------------------------------------#
#                                                                                                                                                                                            #
#                                                                                                                                                                                            #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#System
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias aremove='sudo apt auto-remove'
alias rm='rm -rv'
alias cls='clear'

#Git
alias gcl='git clone'
alias gc='git commit -m'
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'

#Git for dotfiles
alias dg='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dgc='dg commit -m'
alias dga='dg add'
alias dgs='dg status'
alias dgp='dg push'
alias dgpl='dg pull'

#Yarn
alias yi='yarn install'
alias ys='yarn start'
alias ya='yarn add'
alias yr='yarn remove'

#-------------------------------------------------------------------------------------------END OF ALIAS-------------------------------------------------------------------------------------#
#                                                                                                                                                                                            #
#                                                                                                                                                                                            #
#--------------------------------------------------------------------------------------USER DEFINED FUNCTIONS--------------------------------------------------------------------------------#

#Webm Convertor
webm (){
  if [ $# -ne 2 ]; then
    echo "Example usage: webm input.mp4 1920"
    return
  fi

  FILENAME=${1%%.*}
  mkdir webm

  ffmpeg -i $1 -c:v libvpx-vp9 -crf 40 -vf scale=$2:-2 -an webm/${FILENAME}.webm
  ffmpeg -i $1 -c:v libx264 -crf 24 -vf scale=$2:-2 -movflags faststart -an webm/${FILENAME}_h264.mp4
  ffmpeg -i $1 -c:v libx265 -crf 28 -vf scale=$2:-2 -tag:v hvc1 -movflags faststart -an webm/${FILENAME}_h265.mp4
}

#Webp Convertor
webp (){
  if [ $# -ne 1 ]; then
    echo "Example usage: webp filename.png"
    return
  fi

  FILENAME=${1%%.*}
  ffmpeg -i $1 -c libwebp webp_${FILENAME}.webp
}

#Youtube Downloader
yt (){
  if [ $# -ne 1 ]; then
    echo "Example usage: yt 'YouTube URL' "
    return
  fi

  yt-dlp --config-location ~/.config/yt-dlp/config/ $1
}

#Github Repository Initializer
gint () {
  cd ~/Projects
  gh repo create $1 --public --clone
  cd $1
  touch .gitignore
  touch README.md
  git branch -M main
  git add .
  git commit -m 'Repository Initialization 😀'
  git push --set-upstream origin main
  code .
  exit
}

#C# Compile and Runner
cs () {
  mcs "$1".cs
  echo 'Compiled'
  ./"$1".exe
}

#React App Initializer
cra () { 
  name=$1
  cd ~/Projects/ && npx create-react-app "$name" && cd "$name" && code . && exit
}

#ZSHRC Editor 
zshrc () {
  nano ~/.zshrc
  source ~/.zshrc
  clear
}

#VS Code Opener
vs () {
  code .
  exit
}

#Projects Folder Opener
dev () {
  cd ~/Projects
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#																							     #
#																							     #
#----------------------------------------------------------------------------------END OF USER DEFINED FUNCTIONS-----------------------------------------------------------------------------#

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ZSH Defaults
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
