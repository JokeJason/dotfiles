#!/bin/bash

# This is a bash script used to pause/play music from ncmpcpp or spotify using i3wm keybinding. Spotify is the priority

# Spotify is controled using playerctl
# Mopidy+ncmpcpp is controlled using mpc

player_list=$(playerctl -l)
mpd_status=$(mpc status) # This require MPD working (Mopidy or MPD working in backend)

if [[ $player_list == *"spotify"* ]]
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
        notify-send "Unknown argument given for mediactrl.sh $1"
    fi

# # A else case, MPD (mopidy in my case) is assumed working in backend. Currently not working
# elif [[ $mpd_status == *"MPD error"* ]]
# then
#     notify-send "MPD error"
else
    if [[ $1 == "play-pause" ]]
    then
        mpc toggle
    elif [[ $1 == "next" ]]
    then
        mpc next
    elif [[ $1 == "previous" ]]
    then
        mpc prev
    else
        notify-send "Unknown argument given for mediactrl.sh $1"
    fi
fi