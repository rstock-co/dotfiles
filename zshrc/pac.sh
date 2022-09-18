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

# ▓▓▒░  single character aliases currently in use  ░▒▓▓

    # [ i ]