#!/bin/bash

underline_color="%{u#99c2ff}%{+u}"
pomo_message=$(emacsclient -e '(my/emacs-query-pomodoro)' 2>/dev/null | cut -d '"' -f 2)

if [[ -z "$pomo_message" ]]; then
   echo ${underline_color}"No Pomodoro"
else 
   echo ${underline_color}${pomo_message}
fi
