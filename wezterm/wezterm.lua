local wezterm = require 'wezterm'

return {
  leader = { key="b", mods="CTRL" },
  font = wezterm.font('JetBrains Mono'),
  font_size = 13.0, 
  color_scheme = 'Catppuccin Macchiato', -- mocha, frappe, latte
  window_background_opacity = 0.93,
  hide_tab_bar_if_only_one_tab = true,
  enable_scroll_bar = true,
  keys = {
    { key = '"', mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "%", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "o", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Next") },
    { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "l", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { key = "j", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { key = "h", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "k", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
  },
}

