# ▓▓▒░  undo git  ░▒▓▓


  # ▒░ LOCAL STAGING ░▒

    # undo one staged file
      alias  uga="git reset HEAD --"

    # undo multiple staged files with fzf
      alias ugam="git ls-files -c --exclude-standard | fzf -m --print0 | xargs -0 -o -t git reset HEAD --"

    # undo all staged files
      alias ugaa="git reset HEAD -- .;git status"


  # ▒░ LOCAL COMMITS ░▒

    # undo last commit - soft (only unstage the committed files, leaving code untouched [not deleting changes])
      alias ugc="git reset HEAD~"

    # undo last commit - hard (remove the changes from the committed files since previous commit)
      alias ugch="git reset --hard HEAD~"


  # ▒░ REMOTE COMMITS ░▒

    # undo last commit - hard (already pushed to remote)
      alias ugrch='git reset HEAD\^; git push origin +HEAD'
