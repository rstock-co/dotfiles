# ▓▓▒░  lighthouse  ░▒▓▓

  #current project 

    alias   p="cd ~/lighthouse/react/scheduler"
    alias ccp="code ~/lighthouse/react/scheduler"
    alias  sp="p; npm start"
    alias  op="xdg-open http://localhost:8000/"
    alias  ss="p; npm run storybook"
    alias  os="xdg-open http://localhost:9009/"
    alias  tp="p; npm test"
    alias sdb="cd ~/lighthouse/react/scheduler-api; npm start" // vagrant must be up

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