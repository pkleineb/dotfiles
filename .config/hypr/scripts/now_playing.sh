#!/bin/bash

artist=$(playerctl metadata --format '{{artist}}' 2>/dev/null)
title=$(playerctl metadata --format '{{title}}' 2>/dev/null)
art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)

if [ -z "$artist" ]; then
    echo ' '
    exit
fi

# Fetch art to a known cache path so hyprlock can read it
ART_CACHE="/tmp/hyprlock-art.png"

if [ -n "$art_url" ]; then
    if [[ "$art_url" == file://* ]]; then
        # Local file — just copy/convert it
        cp "${art_url#file://}" "$ART_CACHE"
    else
        # Remote URL (Spotify etc.) — download it
        curl -sL "$art_url" -o "$ART_CACHE"
    fi
    pkill -USR2 hyprlock
fi

wrap() {
    local text="$1"
    local limit=18

    if [ ${#text} -gt $limit ]; then
        echo "$text" | fold -s -w $limit | while IFS= read -r line; do
            printf '%-*s\n' "$limit" "$line"
        done
    else
        printf '%-*s\n' "$limit" "$text"
    fi
}

printf '%s\n%s' "$(wrap "$artist")" "$(wrap "$title")"
