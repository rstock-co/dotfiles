# ▓▓▒░  open & edit config files  ░▒▓▓

  # aliases
    alias ea="code ~/.zshrc"
    alias sa="source ~/.zshrc"
    alias va="alias | fzf"

  # i3
    alias i3="code ~/.config/i3/config" # (source with `Ctrl+Shift+c`)

  # alacritty (terminal)
    alias al="code ~/.config/alacritty/alacritty.yml"

  # tmux
    alias tm="code ~/.tmux.conf"

  # powerline
    alias pl="code ~/.config/powerline/"

  # vs code
    alias vs="code ~/.config/Code/User/settings.json"

    alias sh="code ~/zshrc"

  # needs fixing because it opens the correct file but also a 2nd empty file
    # alias sh="cd ~/zshrc; ls | fzf | xargs code -r"