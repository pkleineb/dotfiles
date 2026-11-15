---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/ for more

-- Main modifier
local mainMod = "SUPER" -- windows key

-- assign apps
local term    = "kitty"
local editor  = term .. " nvim"
local file    = "dolphin"
local browser = "firefox"

local scripts = "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/scripts"

-- $scrPath was never defined in the old .conf; it was left for the shell to
-- expand from the environment. Kept as-is. If it should be a fixed path, set it here.
local scrPath = "$scrPath"

local function exec(cmd) return hl.dsp.exec_cmd(cmd) end

-- Rofi is toggled on/off if you repeat the key presses
local rofiEnv = "env XCURSOR_THEME=Bibata-Modern-Ice XCUROSOR_PATH=~/.local/share/icons/"
local function rofi(mode)
    return exec("pkill -x rofi || " .. rofiEnv .. " rofi -show-icons -show " .. mode)
end

-- Flag shortcuts (old bindl = locked, bindel = locked + repeat, binde = repeat)
local LOCKED     = { locked = true }
local LOCKED_REP = { locked = true, repeating = true }
local REPEAT     = { repeating = true }

-- Window/Session actions
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())                                -- kill the window on focus
hl.bind("ALT + F4",                exec(scrPath .. "/dontkillsteam.sh"))                 -- kill the window on focus
hl.bind(mainMod .. " + Delete",    hl.dsp.exit())                                        -- kill hyprland session
hl.bind(mainMod .. " + W",         hl.dsp.window.float({ action = "toggle" }))           -- toggle floating
hl.bind(mainMod .. " + G",         hl.dsp.group.toggle())                                -- toggle group (tab mode)
hl.bind("ALT + Return",            hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- toggle fullscreen
hl.bind(mainMod .. " + L",         exec(scripts .. "/lockscreen.sh"))                    -- lock screen
hl.bind(mainMod .. " + BackSpace", exec(scripts .. "/logoutlaunch.sh"))                  -- logout menu
-- hl.bind("CTRL + Escape",        exec("killall waybar || waybar"))                     -- toggle waybar
hl.bind(mainMod .. " + Space",     hl.dsp.layout("togglesplit"))

-- Application shortcuts
hl.bind(mainMod .. " + T",              exec(term))                  -- open terminal
hl.bind(mainMod .. " + E",              exec(file))                  -- open file manager
hl.bind(mainMod .. " + C",              exec(editor))                -- open neovim
hl.bind(mainMod .. " + F",              exec(browser))               -- open browser
hl.bind("CTRL + SHIFT + Escape",        exec("btop"))                -- open btop
hl.bind(mainMod .. " + D",              exec("discord"))
hl.bind(mainMod .. " + M",              exec(scripts .. "/toggle_tidal.sh"))
hl.bind(mainMod .. " + B",              exec("blueman-manager"))

hl.bind(mainMod .. " + A",   rofi("drun"))        -- launch desktop applications
hl.bind(mainMod .. " + Tab", rofi("window"))      -- switch between desktop applications
hl.bind(mainMod .. " + R",   rofi("filebrowser")) -- browse system files

-- Audio control
hl.bind("F10",                  exec(scrPath .. "/volumecontrol.sh -o m"), LOCKED)     -- toggle audio mute
hl.bind("F11",                  exec(scrPath .. "/volumecontrol.sh -o d"), LOCKED_REP) -- decrease volume
hl.bind("F12",                  exec(scrPath .. "/volumecontrol.sh -o i"), LOCKED_REP) -- increase volume
hl.bind("XF86AudioMute",        exec(scrPath .. "/volumecontrol.sh -o m"), LOCKED)     -- toggle audio mute
hl.bind("XF86AudioMicMute",     exec(scrPath .. "/volumecontrol.sh -i m"), LOCKED)     -- toggle microphone mute
hl.bind("XF86AudioLowerVolume", exec(scrPath .. "/volumecontrol.sh -o d"), LOCKED_REP) -- decrease volume
hl.bind("XF86AudioRaiseVolume", exec(scrPath .. "/volumecontrol.sh -o i"), LOCKED_REP) -- increase volume
hl.bind("XF86AudioPlay",        exec("playerctl play-pause"),              LOCKED)
hl.bind("XF86AudioPause",       exec("playerctl play-pause"),              LOCKED)
hl.bind("XF86AudioNext",        exec("playerctl next"),                    LOCKED)
hl.bind("XF86AudioPrev",        exec("playerctl previous"),                LOCKED)

-- Brightness control
hl.bind("XF86MonBrightnessUp",   exec(scrPath .. "/brightnesscontrol.sh i"), LOCKED_REP) -- increase brightness
hl.bind("XF86MonBrightnessDown", exec(scrPath .. "/brightnesscontrol.sh d"), LOCKED_REP) -- decrease brightness

-- Screenshot/Screencapture
hl.bind(mainMod .. " + P",          exec("~/dotfiles/.config/hypr/scripts/satty_screenshot.sh s")) -- drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + CTRL + P",   exec(scrPath .. "/screenshot.sh sf")) -- frozen screen, drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + ALT + P",    exec(scrPath .. "/screenshot.sh m"))  -- print focused monitor
hl.bind("Print",                    exec(scrPath .. "/screenshot.sh p"))  -- print all monitor outputs

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",           hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- Move window silently to workspace with mainMod + ALT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + ALT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ workspace = "r-1" }))

-- Move to the first empty workspace instantly with mainMod + CTRL + [↓]
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), REPEAT)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), REPEAT)
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), REPEAT)
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), REPEAT)

-- Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
hl.bind(mainMod .. " + CTRL + ALT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + ALT + left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Move active window around current workspace with mainMod + SHIFT + CTRL + [←→↑↓]
-- (the old config wrote "$CONTROL" here, which was never defined; it still matched CTRL)
hl.bind(mainMod .. " + SHIFT + CTRL + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/Resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special workspaces (scratchpad)
-- The unnamed special workspace is internally called "special:special".
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:special", follow = false }))
hl.bind(mainMod .. " + S",       hl.dsp.workspace.toggle_special("special"))

-- Toggle Layout
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle

-- Trigger when the switch is turning off
hl.bind("switch:on:Lid Switch", exec("swaylock && systemctl suspend"), LOCKED)
