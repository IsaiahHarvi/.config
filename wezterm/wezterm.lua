local wezterm = require 'wezterm'


local function in_tmux()
  -- return os.getenv("TMUX") ~= nil
  return true; -- the env var doesnt work idky 
end

return {
  font = wezterm.font('JetBrains Mono'),
  font_size = 13.0, 
  color_scheme = 'Catppuccin Macchiato', -- mocha, frappe, latte
  window_background_opacity = 0.93,
  window_background_gradient = {
    colors = { "#1e3a5f", "#283046" },
    orientation = 'Vertical',
  },
  hide_tab_bar_if_only_one_tab = true,
  enable_scroll_bar = true,

  leader = { key = "b", mods = "CTRL" },
  keys = not in_tmux() and {
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
  } or {}, 
}

