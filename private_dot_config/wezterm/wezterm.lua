local wezterm = require("wezterm")
local action = wezterm.action

return {
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  unicode_version = 15,
  mouse_bindings = {
    {
      event = { Down = { streak = 3, button = "Left" } },
      action = action.SelectTextAtMouseCursor("SemanticZone"),
      mods = "NONE",
    },
  },
  keys = {
    { key = "UpArrow", mods = "SHIFT", action = action.ScrollToPrompt(-1) },
    { key = "DownArrow", mods = "SHIFT", action = action.ScrollToPrompt(1) },
  },
}
