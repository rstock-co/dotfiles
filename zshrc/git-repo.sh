# ▓▓▒░  git repo & ssh commands  ░▒▓▓

  # ▒░ REPOS & GISTS ░▒

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

  # ▒░ SSH ░▒
  
    # "Run" ssh links to clone repos without having to type `git clone`. For example:
    # terminal $> git@github.com:stefanjudis/dotfiles.git
    # (this runs `git clone git@github.com:stefanjudis/dotfiles.git`)
      alias -s git="git clone"

    # generate a new ssh key
      alias newssh="ls ~/.ssh; ssh-keygen -t ed25519 -C 'rstock.co@gmail.com'"

    # copy ssh key from file to clipboard for pasting into Github 
    # syntax: `copssh <ssh key filename>` (ie. filename = 'id_ed25519.pub')

      function copyssh() {
        filename="$*"
        xclip -selection clipboard -i < $filename
      }