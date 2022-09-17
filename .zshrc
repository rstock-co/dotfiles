#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
# s h e l l  a l i a s e s


#  author ▓▒ rstock-co
#    code ▓▒ https://github.com/rstock-co/dotfiles


# ▓▓▒░  single character aliases currently in use  ░▒▓▓

    # [b, c, g, h, i, o, p, r, t]

# ▓▓▒░  print header when terminal opens  ░▒▓▓

    clear
    # echo ▓▒░  ARCH LINUX CUSTOM ZSH SHELL  ░▒▓
    echo It is currently $(date "+%A, %B %-e, %G, %l:%M %P %Z")
    echo User $USER on $TERM running '\uF303' Arch Linux '('`uname -r`')''\uF303'
    echo

# ▓▓▒░  load configs  ░▒▓▓

  # Use z plugin (https://github.com/rupa/z)
    source ~/.config/z.sh

  # fzf config files
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

  # Use powerline
    USE_POWERLINE="true"
    powerline-daemon -q
    source /usr/share/powerline/bindings/zsh/powerline.zsh

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


# ▓▓▒░  navigation  ░▒▓▓

  # local directories - fzf and cd into a list of all local directories
    function c() {
      local dir
      dir=$(find ${1:-.} -type d -maxdepth 1 -print 2> /dev/null | sed 's/^..//' | fzf +m) &&
      cd "$dir"
      ls
    }

  # history - fzf and cd into any history location
    h() {
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

  # list tree | syntax: `lt <depth>` | note: depth is an integer for how many tree levels to display

    function lt(){
      depth="$1"
      exa --tree --level=$depth
    }

# ▓▓▒░  internet bookmarks  ░▒▓▓

  # b - browse chrome bookmarks
    b() {
        bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

        jq_script='
            def ancestors: while(. | length >= 2; del(.[-1,-2]));
            . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

        jq -r "$jq_script" < "$bookmarks_path" \
            | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
            | fzf --ansi \
            | cut -d$'\t' -f2 \
            | xargs open
    }

# ▓▓▒░  lighthouse  ░▒▓▓

  #current project 

    alias   p="cd ~/lighthouse/tweeter"
    alias ccp="code ~/lighthouse/tweeter"
    alias nrl="npm run local"

  #vagrant

    alias  vu="cd ~/lighthouse; vagrant up"
    alias vsh="cd ~/lighthouse; vagrant ssh"
    alias  vh="cd ~/lighthouse; vagrant halt"

  #lecture notes (needs work)

    function tn(){
      type="$1"
      time="$2"
      # instructor="$3"
      # content=Week ${time:1,2}, Day ${time:4,2} - (insert date)
      # echo $content
      cd ~/lighthouse/lighthouse-web-notes; touch ${time}_${type}.md; code ${time}_${type}.md
    }


# ▓▓▒░  dotfile repo  ░▒▓▓

# see https://www.atlassian.com/git/tutorials/dotfiles and https://wiki.archlinux.org/title/Dotfiles

    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    alias     cs='config status'
    alias    cpu='config push origin master'
    
    function ca() {
      file="$*"
      config add $file
    }

    function cc() {
      message="$*"
      config commit -m $message
    }

  # function cpa() {
  #   message="$*"
  #   config add . && config commit -m $message && config push origin master
  # }


# ▓▓▒░  external hard drive  ░▒▓▓

    alias hd="cd /mnt; ls"
    alias mhd="echo 'Lkjuio*8' | sudo -S mount -t ntfs3 /dev/sda1 /mnt"
    alias uhd="echo 'Lkjuio*8' | sudo -S umount /mnt"


# ▓▓▒░  archlinux package management  ░▒▓▓

  # install a package | syntax: `i <package name>`

    function i() {
      package="$*"
      sudo pacman -S $package
    }

    alias  pacman='pacman --color=auto'
    alias  update="sudo pacman -Syu"
    alias orphans="pacman -Qdt"
    alias foreign="pacman -Qm"
    alias  mypacs="pacman -Qet"  # lists the packages i've explicitly installed


# ▓▓▒░  open & edit config files  ░▒▓▓

  # zshrc (aliases)
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


# ▓▓▒░  launch programs  ░▒▓▓

    alias r="ranger"
    alias t="tmux"

# ▓▓▒░  fzf  ░▒▓▓


    alias fp="fzf --preview 'bat --color always --line-range :50 {}'"

# ▓▓▒░  tmux  ░▒▓▓

  #ss - Select selected tmux session
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  ss() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
      fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
  }

  # sp - switch pane
    sp() {
      local panes current_window current_pane target target_window target_pane
      panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
      current_pane=$(tmux display-message -p '#I:#P')
      current_window=$(tmux display-message -p '#I')

      target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

      target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
      target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

      if [[ $current_window -eq $target_window ]]; then
        tmux select-pane -t ${target_window}.${target_pane}
      else
        tmux select-pane -t ${target_window}.${target_pane} &&
        tmux select-window -t $target_window
      fi
    }

  # refresh: exit all except current session
    alias tr="tmux kill-session -a" 

  # kill: completely exit all tmux sessions
    alias tk="tmux kill-server" 


# ▓▓▒░  npm  ░▒▓▓

    # npm install | syntax: `ni <package name>`
    # function ni(){
    #   package="$*"
    #   npm i $package
    # }

    alias  ni='npm install'
    alias nis='npm install --save'
    alias nid='npm install --save-dev'
    alias nig='npm install --global'
    alias  ns='npm start'
    alias  nt='npm test'
    alias nit='npm install && npm test'
    alias  nk='npm link'
    alias  nr='npm run'
    alias npm-reset='rm -rf node_modules && rm -f package-lock.json && npm install && npx node-notifier-cli -t "Done" -m "npm modules reinstalled" -s Glass -i https://cdn.rawgit.com/npm/logos/31945b5c/npm%20square/n-64.png'
    alias dnm='rm -rf node_modules && npm i'


# ▓▓▒░  git  ░▒▓▓

    alias g="git"

  # "Run" ssh links to clone repos without having to type `git clone`. For example:
  # > git@github.com:stefanjudis/dotfiles.git
  # (runs git clone git@github.com:stefanjudis/dotfiles.git)
    alias -s git="git clone"

  # generate a new ssh key
    alias genssh="ls ~/.ssh; ssh-keygen -t ed25519 -C 'rstock.co@gmail.com'"

  # copy ssh key from file to clipboard for pasting into Github 
  # syntax: `copssh <ssh key filename>` (ie. filename = 'id_ed25519.pub')
    function copssh() {
      filename="$*"
      xclip -selection clipboard -i < $filename
    }

  # ▒░ CORE git - Single Commands (always 2 characters) ░▒
    
    alias  gd="git diff"
    alias  gs="git status"
    alias gaa="git add ."
    alias  ga="git add"
    alias  gr="git restore --staged"
    alias gra="git reset HEAD -- ."

    # Remove the last commit (if already pushed to remote) in two commands:
    alias rlc1='git reset HEAD\^'
    alias rlc2='git push origin +HEAD'

  # git commit | syntax: `gc <commit message>`

    function gc() {
      message="$*"
      branch=$(git rev-parse --abbrev-ref HEAD)
      remote=$(git remote)
      git commit -m $message
    }

  # git push

    function gp() {
      branch=$(git rev-parse --abbrev-ref HEAD)
      remote=$(git remote)
      git push $remote $branch
    }

  # ▒░ MULTI-STEP git (always 3 characters) ░▒
  
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

  # ▒░ CREATE new git repos & gists ░▒

  # create new repo from local | syntax: `cr <repo name> <repo description>`
    function cr() {
      name="$1"
      desc="${*:2}"
      gh repo create $name -d $desc --public --clone; cd $name; git branch -m main
    }

  # create gist from local | syntax: `cg <filepath> <gist title>` // note: filepath starts from lighthouse directory
    function cg() {
      filePath="$1"
      title="${*:2}"
      gh gist create ~/lighthouse/$filePath -d $title
    }

  # push an existing local repo to GitHub (then follow prompts)

    alias per="gh repo create"



# ▓▓▒░  in development  ░▒▓▓

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


# ▓▓▒░  powerlevel10k  ░▒▓▓ (move to very top - if going to use again)

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