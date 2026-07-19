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
    hyprctl dispatch movetoworkspace "$active_ws,address:$addr"
else
    hyprctl dispatch movetoworkspacesilent "$special_workspace,address:$addr"
fi
