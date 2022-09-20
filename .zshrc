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



# ▓▓▒░  load config files  ░▒▓▓

  # z plugin (https://github.com/rupa/z)
    source ~/.config/z.sh

  # fzf
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh

  # powerline
    USE_POWERLINE="true"
    powerline-daemon -q
    source /usr/share/powerline/bindings/zsh/powerline.zsh

  # load all of my other config files
    for FILE in ~/zshrc/*; do
        source $FILE
    done


# ▓▓▒░  print header when terminal opens  ░▒▓▓

    clear
    # echo ▓▒░  ARCH LINUX CUSTOM ZSH SHELL  ░▒▓
    echo It is currently $(date "+%A, %B %-e, %G, %l:%M %P %Z")
    echo User $USER on $TERM running '\uF303' Arch Linux '('`uname -r`')''\uF303'


# ▓▓▒░  rick roll ░▒▓▓

    alias rr="curl -s -L http://bit.ly/10hA8iC | bash"


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


# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# oh-my-zsh
# ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
# if [[ ! -d $ZSH_CACHE_DIR ]]; then
#  mkdir $ZSH_CACHE_DIR
# fi

# source $ZSH/oh-my-zsh.sh