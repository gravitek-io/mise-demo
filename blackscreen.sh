#!/usr/bin/env bash

cleanup() {
    tput rmcup
    exit 0
}

trap cleanup INT TERM

tput smcup
tput civis
tput setab 0
tput clear

cols=$(tput cols)
rows=$(tput lines)

msg="press ctrl-c to exit"
x=$(( (cols - ${#msg}) / 2 ))
tput cup $((rows - 2)) $x
tput setaf 7
printf '%s' "$msg"
tput cup $((rows - 1)) 0

tail -f /dev/null
