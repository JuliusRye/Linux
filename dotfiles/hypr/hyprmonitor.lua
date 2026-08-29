------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto-right",
    scale    = "auto",
    disabled = true,
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3440x1440@60",
    position = "auto-left",
    scale    = "auto",
})