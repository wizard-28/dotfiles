local w = require("wezterm")
local act = w.action

return {
	font = w.font("JetBrainsMono Nerd Font"),
	-- window_background_opacity = 0.8,
	color_scheme = "Catppuccin Mocha",
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	unicode_version = 15,
	mouse_bindings = {
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = act.SelectTextAtMouseCursor("SemanticZone"),
			mods = "NONE",
		},
	},
	keys = {
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
		{
			key = "f",
			mods = "CTRL",
			action = act.Multiple({
				act.SpawnCommandInNewTab({
					args = {
						"bash",
						"-c",
						"rg --files $(cat /home/wizard/.local/share/nvim/project_nvim/project_history) | fzf --preview '' --preview='bat --style=plain --color=always {}' --bind 'enter:become(open /home/wizard/.local/share/nvim/project_nvim/project_history | lines | where {|e| '{}' =~ $e} | get 0 | do {|x| cd $in; wezterm cli set-tab-title ($in | path basename);}; nvim {})'",
					},
				}),
				act.ActivateTabRelative(1),
			}),
		},
	},
}
