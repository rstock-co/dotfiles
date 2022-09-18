# ▓▓▒░  internet bookmarks  ░▒▓▓

  # browse/search chrome bookmarks in terminal with fzf
  # requires `jq` package 

    function b() {
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

# ▓▓▒░  single character aliases currently in use  ░▒▓▓

    # [ b ]