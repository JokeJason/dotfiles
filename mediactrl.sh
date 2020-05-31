#!/bin/bash

# This is a bash script used to pause/play music from ncmpcpp or spotify using i3wm keybinding. Spotify is the priority

# Spotify is controled using playerctl
# Mopidy+ncmpcpp is controlled using mpc

if [[ $(playerctl -l) == *"spotify"* ]]
then
    if [[ $1 == "play-pause" ]]
    then
        playerctl play-pause --player spotify
    elif [[ $1 == "next" ]]
    then
        playerctl next --player spotify
    elif [[ $1 == "previous" ]]
    then
        playerctl previous --player spotify
    else
        notify-send "Unknown argument given for mediactrl.sh"
    fi

elif [[ $(mpc status) == *"MPD error"* ]]
then
    notify-send "MPD not initiated"

else
    

    if [[ $1 == "play-pause" ]]
    then
        if  [[ $(mpc status) == *"paused"* ]]
        then
            mpc play
        elif [[ $(mpc status) == *""playing* ]]
        then
            mpc pause
        else
            notify-send "MPD status not clear"
        fi
    fi
fi