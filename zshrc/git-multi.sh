# ▓▓▒░  git multi-step commands  ░▒▓▓

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