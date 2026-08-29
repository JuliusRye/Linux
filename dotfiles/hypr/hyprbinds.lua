---------------------
---- MY PROGRAMS ----
---------------------

--local menu        = "hyprlauncher"
local menu        = "wofi --show drun"
local browser     = "firefox"
local terminal    = "kitty"
local fileManager = "nemo"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local hyper   = "SUPER + SHIFT + ALT + CONTROL"
local meh     = "SHIFT + ALT + CONTROL"

--- Open progrmas ---
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zeditor"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))

--- Manage session ---
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + CONTROL + W", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprpaper"))
hl.bind(hyper .. " + Q", hl.dsp.exit())

--- Manage windows ---
local closeWindowBind = hl.bind(mainMod .. "+ CONTROL + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())    -- dwindle only

--- Change foucs window ---
local directions = {
    left  = "left",
    right = "right",
    up    = "up",
    down  = "down",
}
local resize_steps = {
    left  = { small = { x = -10, y = 0,   relative = true }, large = { x = -100, y = 0,    relative = true }},
    right = { small = { x = 10,  y = 0,   relative = true }, large = { x = 100,  y = 0,    relative = true }},
    up    = { small = { x = 0,   y = -10, relative = true }, large = { x = 0,    y = -100, relative = true }},
    down  = { small = { x = 0,   y = 10,  relative = true }, large = { x = 0,    y = 100,  relative = true }},
}

for key, direction in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(mainMod .. " + CONTROL + " .. key, hl.dsp.window.move({ direction = direction }))
end

for direction, step in pairs(resize_steps) do
    hl.bind(mainMod .. " + SHIFT + " .. direction,
        hl.dsp.window.resize(step.small))

    hl.bind(mainMod .. " + SHIFT + CONTROL + " .. direction,
        hl.dsp.window.resize(step.large))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--- Manage workspaces ---
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CONTROL + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + return",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + CONTROL + return", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

--- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

--- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
