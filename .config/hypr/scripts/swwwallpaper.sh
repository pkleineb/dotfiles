#!/usr/bin/env sh

# define functions

Wall_Update()
{
    if [ ! -d "${cacheDir}/${curTheme}" ] ; then
        mkdir -p "${cacheDir}/${curTheme}"
    fi

    local x_wall="$1"
    local x_update="${x_wall/$HOME/"~"}"
    cacheImg=$(basename "$x_wall")
    $ScrDir/swwwallbash.sh "$x_wall" &

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}" ] ; then
        convert -strip "$x_wall" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${curTheme}/${cacheImg}" &
    fi

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}.rofi" ] ; then
        convert -strip -resize 2000 -gravity center -extent 2000 -quality 90 "$x_wall" "${cacheDir}/${curTheme}/${cacheImg}.rofi" &
    fi

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}.blur" ] ; then
        convert -strip -scale 10% -blur 0x3 -resize 100% "$x_wall" "${cacheDir}/${curTheme}/${cacheImg}.blur" &
    fi

    wait
    awk -F '|' -v thm="${curTheme}" -v wal="${x_update}" '{OFS=FS} {if($2==thm)$NF=wal;print$0}' "${ThemeCtl}" > "${ScrDir}/tmp" && mv "${ScrDir}/tmp" "${ThemeCtl}"
    ln -fs "${x_wall}" "${wallSet}"
    ln -fs "${cacheDir}/${curTheme}/${cacheImg}.rofi" "${wallRfi}"
    ln -fs "${cacheDir}/${curTheme}/${cacheImg}.blur" "${wallBlr}"
}

Wall_Change()
{
    local x_switch=$1

    for (( i=0 ; i<${#Wallist[@]} ; i++ ))
    do
        if [ "${Wallist[i]}" == "${fullPath}" ] ; then

            if [ $x_switch == 'n' ] ; then
                nextIndex=$(( (i + 1) % ${#Wallist[@]} ))
            elif [ $x_switch == 'p' ] ; then
                nextIndex=$(( i - 1 ))
            fi

            Wall_Update "${Wallist[nextIndex]}"
            break
        fi
    done
}

Wall_Set()
{
    if [ -z $xtrans ] ; then
        xtrans="grow"
    fi

    swww img "$wallSet" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type "$xtrans" \
    --transition-duration 0.7 \
    --transition-fps 60 \
    --invert-y \
    --transition-pos "$( hyprctl cursorpos )"
}


# set variables

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
wallSet="${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.set"
wallBlr="${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.blur"
wallRfi="${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.rofi"
ctlLine=$(grep '^1|' ${ThemeCtl})

if [ `echo $ctlLine | wc -l` -ne "1" ] ; then
    echo "ERROR : ${ThemeCtl} Unable to fetch theme..."
    exit 1
fi

curTheme=$(echo "$ctlLine" | awk -F '|' '{print $2}')
fullPath=$(echo "$ctlLine" | awk -F '|' '{print $NF}' | sed "s+~+$HOME+")
wallName=$(basename "$fullPath")
wallPath=$(dirname "$fullPath")
mapfile -d '' Wallist < <(find ${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)

if [ ! -f "$fullPath" ] ; then
    if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/swww/$curTheme" ] ; then
        wallPath="${XDG_CONFIG_HOME:-$HOME/.config}/swww/$curTheme"
        mapfile -d '' Wallist < <(find ${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)
        fullPath="${Wallist[0]}"
    else
        echo "ERROR: wallpaper $fullPath not found..."
        exit 1
    fi
fi


# evaluate options

while getopts "nps" option ; do
    case $option in
    n ) # set next wallpaper
        xtrans="grow"
        Wall_Change n ;;
    p ) # set previous wallpaper
        xtrans="outer"
        Wall_Change p ;;
    s ) # set input wallpaper
        shift $((OPTIND -1))
        if [ -f "$1" ] ; then
            Wall_Update "$1"
        fi ;;
    * ) # invalid option
        echo "n : set next wall"
        echo "p : set previous wall"
        echo "s : set input wallpaper"
        exit 1 ;;
    esac
done

# Function to start swww daemon if not running
start_swww_daemon()
{
    # Check if daemon is already running
    if ! swww query >/dev/null 2>&1; then
        echo "Starting swww daemon..."

        if command -v swww-daemon >/dev/null 2>&1; then
            swww-daemon &
            sleep 2
        else
            echo "ERROR: swww-daemon not found. Please ensure swww 0.10.0+ is properly installed."
            exit 1
        fi

        # Verify daemon started successfully
        if ! swww query >/dev/null 2>&1; then
            echo "ERROR: Failed to start swww daemon"
            exit 1
        fi
        echo "swww daemon started successfully"
    fi
}


start_swww_daemon
# check swww daemon and set wall
Wall_Set
