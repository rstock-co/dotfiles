# ▓▓▒░  git  ░▒▓▓

    alias   g="git"
    alias  gd="git diff"
    alias  gs="git status"
    alias  ga="git add"
    alias  gc="git commit -m"
    alias  gb="git branch"
    alias gco="git checkout"
    alias gaa="git add .;git status"

  # git add multiple files using fuzzy filter
    alias gam="git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add"

  # git push

    function gp() {
      branch=$(git rev-parse --abbrev-ref HEAD)
      remote=$(git remote)
      git push $remote $branch
    }

  # git diff preview

    function gdp() {
      preview="git diff $@ --color=always -- {-1}"
      git diff $@ --name-only | fzf -m --ansi --preview $preview
    }


# ▓▓▒░  single character aliases  ░▒▓▓

  # [ g ]
