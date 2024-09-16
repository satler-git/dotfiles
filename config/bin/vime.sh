#!/usr/bin/env bash

declare -r clip_file="/tmp/clip.txt"
declare -r nvim="nvim"

[[ -f ${clip_file} ]] && rm ${clip_file}
touch ${clip_file}

NVIM_APPNAME=nvim-ime alacritty --class FloatingVim -e ${nvim} ${clip_file} || exit 1

head -c -1 ${clip_file} | wl-copy
