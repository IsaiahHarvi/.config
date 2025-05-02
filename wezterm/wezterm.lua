local wezterm = require 'wezterm'

local function in_tmux()
  -- return os.getenv("TMUX") ~= nil
  return 1
end

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    default_cursor_style = "SteadyBlock",
    font = wezterm.font('JetBrains Mono', { weight = "Bold" }),
    font_size = 13.0,
    color_scheme = 'Catppuccin Macchiato', -- mocha, frappe, latte
    background = {
        {
            source = {
                File = "/Users/iharville/Pictures/bg-montery.jpg",
            },
            hsb = {
                hue = 1.0,
                saturation = 1.02,
                brightness = 0.25,
            },
        },
        {
            source = {
                Color = "#282c35",
            },
            width = "100%",
            height = "100%",
            opacity = 0.55
        },
    },
}

if not in_tmux() then
  config.leader = { key = "b", mods = "CTRL" }
  config.keys = {
    -- Splits
    { key = "%", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = '"', mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

    -- Switch to the next pane
    { key = "o", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Next") },

    -- Close the current pane
    { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane { confirm = false } },

    -- Switch between tabs
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

    -- Resize panes
    { key = "l", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { key = "j", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { key = "h", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "k", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
  }
end

return config

