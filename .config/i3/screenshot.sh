#!/bin/bash
filename=$(rofi -dmenu -p "filename" -fixed-num-lines 0)
if [ -n "$filename" ]; then
		mkdir -p $HOME/screenshots
    scrot -s "$HOME/screenshots/$filename.png"
fi
