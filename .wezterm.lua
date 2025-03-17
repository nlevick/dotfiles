--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- settings
-- config.default_prog = { "../../Program Files/Git/bin/bash.exe", "--login" }

config.font_size = 12
config.font = wezterm.font_with_fallback({
	-- { family = "VictorMono Nerd Font Mono", scale = 1.0, weight = "Bold" },
	-- { family = "IosevkaTerm Nerd Font", scale = 1.0, weight = "Medium" },
	-- { family = "Maple Mono", scale = 1.0, weight = "Light" },
})

config.color_schemes = {
	["My Scheme"] = {
		foreground = "#CBE0F0",
		background = "#011423",
		cursor_bg = "#ff0000",
		cursor_border = "#ff0000",
		cursor_fg = "#011423",
		selection_bg = "#033259",
		selection_fg = "#CBE0F0",
		ansi = {
			"#214969",
			"#E52E2E",
			"#44FFB1",
			"#FFE073",
			"#0FC5ED",
			"#a277ff",
			"#24EAF7",
			"#24EAF7",
		},
		brights = {
			"#214969",
			"#E52E2E",
			"#44FFB1",
			"#FFE073",
			"#A277FF",
			"#a277ff",
			"#24EAF7",
			"#24EAF7",
		},
	},
}

config.color_scheme = "My Scheme"

-- config.color_scheme = "Tokyo Night (Gogh)"
-- config.color_scheme = "Rebecca (base16)"
-- config.color_scheme = "Laserwave (Gogh)"
-- config.color_scheme = "Lumifoo (terminal.sexy)"
-- config.color_scheme = "Lunaria Dark (Gogh)"
-- config.color_scheme = "Jellybeans"

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.2,
}

-- Keys
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	-- { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
	-- { key = "a", mods = "CTRL", action = act.ActivateCommandPalette },
	{ key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	-- Pane keybindings
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- Tab keybindings
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "T", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "e",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Renaming Tab Title...:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

	-- Lastly, workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{ key = "]", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
	{ key = "[", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- Tab bar
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Laserwave (Gogh)",
		tabs_enabled = true,
		theme_overrides = {
			normal_mode = {
				-- a = { fg = "#A277FF", bg = "#033259" },
				a = { bg = "#A277FF", fg = "#011423" },
				b = { fg = "#44FFB1", bg = "#011423" },
				c = { fg = "#CBE0F0", bg = "#011423" },
			},
			tab = {
				active = { fg = "#0FC5ED", bg = "#214969" },
				inactive = { fg = "#CBE0F0", bg = "#011423" },
				inactive_hover = { fg = "#FFE073", bg = "#313244" },
			},
		},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "workspace" },
		tabline_b = { " " },
		tabline_c = { " " },
		tab_active = {
			"index",
			"tab",
			{ "process", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", "tab", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "" },
	},
	extensions = {},
})
tabline.apply_to_config(config)

return config
