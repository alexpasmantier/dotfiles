-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({ match = { class = "(org.gnome.Nautilus|signal|whatsapp)" },      workspace = "1" })
hl.window_rule({ match = { class = "firefox" },                                   workspace = "2" })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" },                     workspace = "3" })
hl.window_rule({ match = { class = "(dev.zed.Zed|Code|jetbrains-rustrover)" },    workspace = "4" })
hl.window_rule({ match = { class = "(Spotify|spotify)" },                         workspace = "5" })

-- Float kitty windows titled "kitty"
hl.window_rule({ match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- no borders when only one window
hl.workspace_rule({ workspace = "w[tv1]", border_size = 0 })
