# ▓▓▒░  tmux  ░▒▓▓

  #ss - Select selected tmux session
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
    function ss() {
        local session
        session=$(tmux list-sessions -F "#{session_name}" | \
        fzf --query="$1" --select-1 --exit-0) &&
        tmux switch-client -t "$session"
    }

  # sp - switch pane
    function sp() {
      local panes current_window current_pane target target_window target_pane
      panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
      current_pane=$(tmux display-message -p '#I:#P')
      current_window=$(tmux display-message -p '#I')

      target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

      target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
      target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

      if [[ $current_window -eq $target_window ]]; then
        tmux select-pane -t ${target_window}.${target_pane}
      else
        tmux select-pane -t ${target_window}.${target_pane} &&
        tmux select-window -t $target_window
      fi
    }

  # refresh: exit all except current session
    alias tr="tmux kill-session -a" 

  # kill: completely exit all tmux sessions
    alias tk="tmux kill-server" 
