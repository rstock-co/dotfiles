# ▓▓▒░  navigation  ░▒▓▓

  # find ALL local directories then fzf and cd into (and list contents)
    function fad() {
      local dir
      dir=$(find ${1:-.} -type d -maxdepth 1 -print 2> /dev/null | sed 's/^..//' | fzf-tmux +m) &&
      cd "$dir"
      ls
    }

# find local directories then fzf and cd into (and list contents)
    function fd() {
      DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
        && cd "$DIR"
        ls
    }

  # shell history - fzf and cd into any history location
    function h() {
      [ $# -gt 0 ] && _z "$*" && return
      cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
    }

    alias    ~="cd ~"
    alias   ..="cd .."
    alias  ...="cd ../.."
    alias ....="cd ../../.."

  # file listing using exa with colors and icons

    alias ls='exa -a --color=always --group-directories-first --icons --git'
    alias ll='exa -la --color=always --group-directories-first --icons --git'
    
# file preview using bat/fzf with text coloring
    
    alias fp="fzf --preview 'bat --color always --line-range :50 {}'"

  # list tree | syntax: `lt <depth>` | note: depth is an integer for how many tree levels to display

    function lt(){
      depth="$1"
      exa --tree --level=$depth
    }

# ▓▓▒░  external hard drive  ░▒▓▓

    alias hd="cd /mnt; ls"
    alias mhd="echo 'Lkjuio*8' | sudo -S mount -t ntfs3 /dev/sda1 /mnt"
    alias uhd="echo 'Lkjuio*8' | sudo -S umount /mnt"