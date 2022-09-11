# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh installation.
# ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# Use z plugin (https://github.com/rupa/z)
source ~/.config/z.sh

# fzf config files
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Use powerline
USE_POWERLINE="true"

# testing that git will pick up changes in symlinked file

powerline-daemon -q
source /usr/share/powerline/bindings/zsh/powerline.zsh

#--------------#
# DOTFILE REPO #
#--------------#

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cs='config status'
function ca() {
  file="$*"
  config add $file
}
function cc() {
  message="$*"
  config commit -m $message
}
alias cp='config push origin master'

# function cpa() {
#   message="$*"
#   config add . && config commit -m $message && config push origin master
# }


#-----------------#
# GENERAL UTILITY #
#-----------------#

# general utility
alias sn="sudo shutdown now"
alias rn="sudo reboot now"
alias c="clear"

# external hard drive
alias hd="cd /mnt; ls"
alias mhd="sudo mount -t ntfs3 /dev/sdb1 /mnt"
alias uhd="sudo umount /mnt"

#--------------------#
# PACKAGE MANAGEMENT #
#--------------------#

# install a package | syntax: `i <package name>`
function i() {
  package="$*"
  sudo pacman -S $package
}

alias update="sudo pacman -Syu"
alias orphans="pacman -Qdt"
alias foreign="pacman -Qm"
alias mypacks="pacman -Qet"  # lists the packages that i've explicitly installed

#--------------------------#
# OPEN / EDIT CONFIG FILES #
#--------------------------#

# zshrc (aliases)
alias ea="code ~/.zshrc"
alias sa="source ~/.zshrc"

# i3
alias i3="code ~/.config/i3/config"
# source with `Ctrl+Shift+c`

# alacritty (terminal)
alias al="code ~/.config/alacritty/alacritty.yml"
# exit all terminal windows and restart to source aliases

# tmux
alias tm="code ~/.tmux.conf"
# kill tmux server and restart tmux to source aliases

# powerline
alias pl="code ~/.config/powerline/"

#----------#
# PROGRAMS #
#----------#

# launch progrmas
alias r="ranger"
alias t="tmux"

# tmux
alias trf="tmux kill-session -a" # refresh: exit all except current session
alias tk="tmux kill-server" # kill: completely exit all tmux sessions

# npm install | syntax: `ni <package name>`
function ni(){
  package="$*"
  npm i $package
}

#-----#
# GIT #
#-----#

alias g="git"

# **
#  Core - Single Commands (always 2 characters)
# ** 

alias gd="git diff"
alias gs="git status"

alias ga="git add ."

# git commit | syntax: `gc <commit message>`
function gc() {
  message="$*"
  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  git commit -m $message
}

function gp() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  git push $remote $branch
}

# **
#  Core - Multistep (always 3 characters)
# ** 

# git push all | syntax: `gpa <commit message>` | to push all current work to current branch
function gpa() {
  message="$*"
  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  git status && git add . && git commit -m $message && git push $remote $branch
}

# git push one | syntax: `gpo <filename> <message>` | to push one file to current branch
function gpo() {
  file="$1"
  message="${*:2}"
  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  git status && git add $file && git commit -m $message && git push $remote $branch
}

# git push multiple | syntax: `gpm <file 1 file 2 file 3..>,<message>` | NOTE: commit messages cannot have any symbols
function gpm() {
  oldIFS=$IFS   # save IFS, the field separator
  IFS=' '
  result="$*"
  
  IFS=',' 
  read -A strarr <<< "$result"
  filenames=${strarr[@][1]}
  message=${strarr[@][2]}
  
  IFS=$oldIFS   # restore IFS

  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  
  git status 

  for file in $(echo $filenames); do
    git add $file
  done
  git commit -m $message && git push $remote $branch
}

# create new branch | syntax: `gnb <new branch name>`
function gnb() {
  name="$1"
  git checkout -b $name
}

# push new branch | syntax: `gnp <commit message>`
function gnp() {
  message="$*"
  branch=$(git rev-parse --abbrev-ref HEAD)
  remote=$(git remote)
  git status && git add . && git commit -m $message && git push -u origin $branch
}

# **
#  Create repos / gists
# ** 

# create repo | syntax: `cr <repo name> <repo description>`
function cr() {
  name="$1"
  desc="${*:2}"
  gh repo create $name -d $desc --public --clone; cd $name; git branch -m main
}

# create gist | syntax: `cg <filepath> <gist title>` // note: filepath starts from lighthouse directory
function cg() {
  filePath="$1"
  title="${*:2}"
  gh gist create ~/lighthouse/$filePath -d $title
}

# clone repo | syntax: ???


#------------#
# NAVIGATION #
#------------#

alias .="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Lighthouse current project
alias p="cd ~/lighthouse/tinyapp"

# file listing using exa with colors and icons
alias ls='exa -a --color=always --group-directories-first --icons'

# list tree | syntax: `lt <depth>` | note: depth is an integer for how many tree levels to display
function lt(){
  depth="$1"
  exa --tree --level=$depth
}

#------------#
# LIGHTHOUSE #
#------------#

# vagrant commands (remember, can only run these outside of vagrant machine)
alias vu="cd ~/lighthouse; vagrant up"
alias vs="cd ~/lighthouse; vagrant ssh"
alias vh="cd ~/lighthouse; vagrant halt"

# Lecture Notes (in development)
function tn(){
  type="$1"
  time="$2"
  # instructor="$3"
  # content=Week ${time:1,2}, Day ${time:4,2} - (insert date)
  # echo $content
  cd ~/lighthouse/lighthouse-web-notes; touch ${time}_${type}.md; code ${time}_${type}.md
}

# ---------------#
# IN DEVELOPMENT #
# ---------------#

# cli command: syntax `mdn <topic>` - opens browser with mdn topic
function mdn(){
  url="$*"
  xdg-open https://developer.mozilla.org/en-US/search?q=$url
}

# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# oh-my-zsh
# ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
# if [[ ! -d $ZSH_CACHE_DIR ]]; then
#  mkdir $ZSH_CACHE_DIR
# fi

# source $ZSH/oh-my-zsh.sh