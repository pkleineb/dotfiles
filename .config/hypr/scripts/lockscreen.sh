#!/bin/bash

ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
sed "s/\$ACTIVE_MONITOR/$ACTIVE_MONITOR/g" ~/.config/hypr/hyprlock.conf > /tmp/hyprlock-active.conf

hyprlock --config /tmp/hyprlock-active.conf
