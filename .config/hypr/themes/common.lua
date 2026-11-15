-- Shared theme settings

-- A former `exec =` runs on every config reload (unlike exec-once), so these
-- commands are re-run whenever the config reloads. They are idempotent.
local function apply_cursor_and_fonts()
    -------------
    -- CURSOR --
    -------------
    -- hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
    -- hl.env("XCURSOR_SIZE", "20")

    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 20")

    ------------
    -- FONT --
    ------------
    hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font Mono 9'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface font-hinting 'full'")
end

hl.on("hyprland.start",   apply_cursor_and_fonts)
hl.on("config.reloaded",  apply_cursor_and_fonts)

-------------
-- SPECIAL --
-------------
hl.config({
    decoration = {
        dim_special = 0.3,
        blur = {
            special = true,
        },
    },
})
