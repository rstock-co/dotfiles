# ▓▓▒░  lighthouse  ░▒▓▓

  #current project 

    alias   p="cd ~/lighthouse/Food-Pickup-Ordering"
    alias ccp="code ~/lighthouse/Food-Pickup-Ordering"
    alias  sp="p; npm run local" // this can only be run inside vagrant
    alias gtp="xdg-open http://localhost:8080/"
    alias rdb="npm run db:reset" // this can only be run inside vagrant

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


# ▓▓▒░  single character aliases  ░▒▓▓

  # [ p ]