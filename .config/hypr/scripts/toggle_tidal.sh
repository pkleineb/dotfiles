#!/usr/bin/env bash

class="tidal-hifi"
special_workspace="special:minimized"

addr=$(hyprctl clients -j | jq -r --arg class "$class" \
    '.[] | select(.class == $class) | .address')

if [ -z "$addr" ]; then
    tidal-hifi &
    exit 0
fi

current_ws=$(hyprctl clients -j | jq -r --arg addr "$addr" \
    '.[] | select(.address == $addr) | .workspace.name')

if [ "$current_ws" == "$special_workspace" ]; then
    active_ws=$(hyprctl activeworkspace -j | jq -r '.name')
    hyprctl dispatch "hl.dsp.window.move({ workspace = '$active_ws', window = 'address:$addr' })"
else
    hyprctl dispatch "hl.dsp.window.move({ workspace = '$special_workspace', follow = false, window = 'address:$addr' })"
fi
