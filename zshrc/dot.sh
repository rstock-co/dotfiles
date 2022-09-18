# ▓▓▒░  dotfile repo  ░▒▓▓

  # see https://www.atlassian.com/git/tutorials/dotfiles 
  # and https://wiki.archlinux.org/title/Dotfiles

    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    alias     cs='config status'
    alias     ca='config add'
    # alias     cc='config commit -m'
    alias    cpu='config push origin master'

    function cc() {
      message="$*"
      config commit -m $message
    }

  # function cpa() {
  #   message="$*"
  #   config add . && config commit -m $message && config push origin master
  # }