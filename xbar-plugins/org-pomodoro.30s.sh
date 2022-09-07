#!/usr/bin/env bash

PATH=/opt/homebrew/bin/:$PATH  

symbol="🍅 "
pomo_message=$(emacsclient -e '(my/emacs-query-pomodoro)' 2>/dev/null | cut -d '"' -f 2)

if [[ -z "$pomo_message" ]]; then
   echo ${symbol}"None"
else 
   printf "${symbol}${pomo_message}"
fi
