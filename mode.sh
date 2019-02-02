#!/usr/bin/env bash
source $HOME/dotfiles/util.sh
info_msg "[$(whoami)] Welcome to mode setup!"

# TODO: web_mode, me_mode
function start_mode {
    info_msg "Choose a mode!"
    select option in "coding" "web" "me" "quit"; do
        case $option in
            coding) nohup bash -c coding_mode &;;
            web) exit 0;;
            me) kill_bars ; exit 0;;
            quit) exit 0;;
            *) warn_msg "Please, select an option!";;
        esac
    done
}

function kill_bars {
    notify-send "[INFO] Killing bars (bbar and lbar)..."
    setsid killall loadbars.sh 2> /dev/null
    setsid killall macopix 2> /dev/null
}

function coding_mode {
    setsid feh --bg-scale $HOME/modes/wallpapers/coding/earth_space.jpg &
    kill_bars

    notify-send "[INFO] Inner and Outer gaps set to 0..."
    i3-msg "gaps inner all set 0" > /dev/null 2>&1
    i3-msg "gaps outer all set 0" > /dev/null 2>&1

    notify-send "[INFO] Killing all '1: web' workspace windows..."
    i3-msg workspace '1: web', focus parent, kill > /dev/null 2>&1

    notify-send "[INFO] Loading layout file into i3..."
    i3-msg "workspace 1: web; append_layout $HOME/layout.json" > /dev/null 2>&1

    notify-send "[INFO] Starting Termite with Tmux..."
    setsid termite -e tmux &

    notify-send "[INFO] Starting VS Code..."
    setsid code &

    notify-send "[INFO] Starting Emacs..."
    setsid emacs &

    notify-send "[INFO] Starting Nautilus..."
    setsid nautilus &

    notify-send "[INFO] Starting Chrome with Momentum..."
    setsid google-chrome-stable --app chrome-extension://laookkfknpbbblfpciffpaejjkokdgca/dashboard.html > /dev/null 2>&1 &
    exit 0
}

function web_mode {
    return
}

function me_mode {
    return
}

export -f kill_bars
export -f coding_mode
export -f web_mode
export -f me_mode

start_mode
