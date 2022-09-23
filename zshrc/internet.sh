# ▓▓▒░  internet bookmarks  ░▒▓▓

  # browse/search chrome bookmarks in terminal with fzf
  # requires `jq` package 

    function ib() {
        bookmarks_path=/home/neo/.config/google-chrome/Default/Bookmarks

        jq_script='
            def ancestors: while(. | length >= 2; del(.[-1,-2]));
            . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

        jq -r "$jq_script" < "$bookmarks_path" \
            | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
            | fzf --ansi \
            | cut -d$'\t' -f2 \
            | xargs xdg-open
    }

    # browse/search chrome history in terminal with fzf
    function ih() {
        local cols sep google_history open
        cols=$(( COLUMNS / 3 ))
        sep='{::}'

        google_history="$HOME/.config/google-chrome/Default/History"
        open=xdg-open

        cp -f "$google_history" /tmp/h
        sqlite3 -separator $sep /tmp/h \
            "select substr(title, 1, $cols), url
            from urls order by last_visit_time desc" |
        awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
        fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
    }