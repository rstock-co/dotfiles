# ▓▓▒░  sys  ░▒▓▓

    alias sudo='sudo ' # hack to allow aliases with sudo
    alias   sd="echo 'Lkjuio*8' | sudo -S shutdown"
    alias   rb="echo 'Lkjuio*8' | sudo -S reboot"
    alias   cl="clear"
    alias   mv="mv -iv"
    alias   cp="cp -iv"
    alias   md="mkdir -v"
    alias   rm='rm -rf'
    alias    o='i3-dmenu-desktop --dmenu=fzf'

  # grep
    alias grep='grep --color=auto -i'

  # ip address
    # alias ip="echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

  # fkill - kill processes - list only the ones you can kill. Modified the earlier script.
    function fkill() {
      local pid 
      if [ "$UID" != "0" ]; then
          pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
      else
          pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
      fi  

      if [ "x$pid" != "x" ]
      then
          echo $pid | xargs kill -${1:-9}
      fi  
    }