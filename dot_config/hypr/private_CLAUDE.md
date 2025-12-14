# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Hyprland Configuration

This is a configuration directory for Hyprland, a dynamic tiling Wayland compositor. The configuration controls window management, keybindings, visual effects, idle behavior, lock screen, and wallpapers.

## File Structure

- **hyprland.conf** - Main Hyprland configuration (monitors, keybindings, window rules, animations, appearance)
- **hypridle.conf** - Idle management (screen dimming, locking, DPMS, suspend timers)
- **hyprlock.conf** - Lock screen appearance and behavior
- **hyprpaper.conf** - Wallpaper configuration
- **scripts/** - Custom shell scripts for enhanced functionality

## Configuration Validation

Before making changes:
- Test configuration syntax: `hyprctl reload` (reloads config without restarting)
- Check for errors: `hyprctl clients` or `hyprctl monitors` to verify Hyprland is responding
- View logs: `journalctl --user -u hyprland -f` (if running as systemd service)

After editing:
- Reload configuration with `SUPER + Backspace` (exits Hyprland) or `hyprctl reload`
- For hypridle/hyprlock changes: `killall hypridle && hypridle &` or `killall hyprlock`

## Key Configuration Patterns

**Keybindings:**
- Main modifier: `$mainMod = SUPER` (Windows key)
- Format: `bind = MODS, KEY, ACTION, PARAMS`
- Repeatable binds: `binde = ...` (holds repeat when key held)
- Mouse binds: `bindm = ...` (for drag operations)

**Window Rules:**
- Static rules: `windowrule = RULE, CRITERIA`
- V2 rules: `windowrulev2 = RULE, CRITERIA`
- Workspace assignments: `windowrule = workspace N, class:(app-class)`

**Environment Variables:**
- Set in config: `env = VAR_NAME,value`
- Apply immediately on reload

**Animations:**
- Bezier curves: `bezier = name, x0, y0, x1, y1`
- Animation specs: `animation = name, enabled, speed, curve, [style]`

## Custom Scripts

**scripts/alt-tab.sh:**
- Advanced window switcher with focus history tracking
- Supports reverse direction (`--reverse`), same-type filtering (`--same`), visible-only (`--visible`)
- Uses hyprctl and jq for window management
- State stored in `/tmp/hypr-alt-tab/`

When modifying scripts:
- Ensure executable: `chmod +x scripts/script-name.sh`
- Test independently: `./scripts/script-name.sh --args`
- Check dependencies: `jq`, `bc`, `hyprctl` required for alt-tab.sh

## Common Customizations

**Adding new keybindings:**
Add to keybindings section in hyprland.conf:
```
bind = $mainMod SHIFT, N, exec, command-here
```

**Changing monitor configuration:**
Edit monitor lines at top of hyprland.conf:
```
monitor=NAME,WIDTHxHEIGHT@RATE,POSITION,SCALE
```

**Adjusting idle/lock timers:**
Edit listener blocks in hypridle.conf (timeouts in seconds)

**Window rules for new applications:**
1. Get window class: `hyprctl clients | grep class`
2. Add rule in windowrule section of hyprland.conf

## Dependencies

Required packages (Arch Linux package names):
- hyprland - Main compositor
- hypridle - Idle daemon
- hyprlock - Screen locker
- hyprpaper - Wallpaper utility
- waybar - Status bar (autostarted)
- albert - Application launcher
- brightnessctl - Brightness control
- playerctl - Media control
- jq - JSON processing (for scripts)
- bc - Calculator (for scripts)

## Programs Referenced

- Terminal: ghostty
- Browser: firefox
- File Manager: nautilus
- Screenshot: hyprshot

When modifying program variables, update in the "MY PROGRAMS" section of hyprland.conf.
