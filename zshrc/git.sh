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

  # ▒░ CORE git - Single Commands ░▒
    
    alias  gd="git diff"
    alias  gs="git status"
    alias  ga="git add"
    alias  gc="git commit -m"
    alias gaa="git add ."

    alias gam="git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add"
  
  # git push

    function gp() {
      branch=$(git rev-parse --abbrev-ref HEAD)
      remote=$(git remote)
      git push $remote $branch
    }

    function fd() {
      preview="git diff $@ --color=always -- {-1}"
      git diff $@ --name-only | fzf -m --ansi --preview $preview
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


# ▓▓▒░  undo git  ░▒▓▓

    alias uga="git restore --staged"
    alias ugc="git reset HEAD -- ."

  # Remove the last commit (if already pushed to remote) in two commands:
    alias rlc1='git reset HEAD\^'
    alias rlc2='git push origin +HEAD'


# ▓▓▒░  single character aliases currently in use  ░▒▓▓

    # [ g ]