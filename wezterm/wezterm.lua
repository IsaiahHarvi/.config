local wezterm = require 'wezterm'

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

return config

