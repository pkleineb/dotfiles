------------------
---- MONITORS ----
------------------

-- Set your monitor configuration here
-- See https://wiki.hypr.land/configuring/core/monitors/

hl.monitor({ output = "DP-1",     mode = "1920x1080@144", position = "0x0",       scale = 1 })
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@60",  position = "-1920x0",   scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60",  position = "-3840x0",   scale = 1 })

hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
