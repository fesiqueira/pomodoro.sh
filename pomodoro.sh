#!/bin/sh

notify() {
    notify-send "pomodoro.sh" "$1" && sleep "$2"
}

pomodoro_start() {
    notify "Start working!" 1500
}

pomodoro_stop() {
    notify "Stop!" 300
}

pomodoro_back_to_work() {
    notify "Back to work!" 1500
}

is_running() {
    pkill -0 -f ".*pomodoro.sh$"
    return $?
}

stop_running() {
    kill -2 -$(ps xao pgid,comm,args | awk '/pomodoro.sh$/ { print $1 } ')
}

begin() {
    pomodoro_start
    while true; do
        pomodoro_stop
        pomodoro_back_to_work
    done
}

case "$1" in
    stop)
        is_running || { echo "pomodoro.sh is not running" && exit 0 ; }
        echo "Good bye! See you soon" && stop_running
        ;;
    *)
        begin &
esac

