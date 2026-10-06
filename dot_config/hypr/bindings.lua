-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "echo -n '[\"toggle\"]' | nc -U ~/.cache/albert/ipc_socket"
local browser     = "firefox"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Return",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W",           hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + W",   hl.dsp.window.kill())
hl.bind(mainMod .. " + M",           hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + M",   hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Backspace",   hl.dsp.exit())
hl.bind(mainMod .. " + F",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Y",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space",       hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
-- hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + CTRL + Q",    hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + Q",   hl.dsp.exec_cmd("poweroff"))
hl.bind("PRINT",                     hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + PRINT",       hl.dsp.exec_cmd("hyprshot -m fullscreen"))
hl.bind(mainMod .. " + P",           hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + P",   hl.dsp.exec_cmd("hyprshot -m fullscreen"))
hl.bind(mainMod .. " + C",           hl.dsp.window.center())
hl.bind(mainMod .. " + G",           hl.dsp.exec_cmd(browser .. " --new-window https://www.chatgpt.com/"))

-- Move / resize the active window
hl.bind(mainMod .. " + left",        hl.dsp.window.move({ x = -20, y = 0,   relative = true }),   { repeating = true })
hl.bind(mainMod .. " + right",       hl.dsp.window.move({ x = 20,  y = 0,   relative = true }),   { repeating = true })
hl.bind(mainMod .. " + up",          hl.dsp.window.move({ x = 0,   y = -20, relative = true }),   { repeating = true })
hl.bind(mainMod .. " + down",        hl.dsp.window.move({ x = 0,   y = 20,  relative = true }),   { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -20, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.resize({ x = 0,   y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }), { repeating = true })

-- alt tab
hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [1-5]
-- Move active window to a workspace with mainMod + CTRL + [1-5]
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,          hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. i,   hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
