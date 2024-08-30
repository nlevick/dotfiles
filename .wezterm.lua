--- wezterm.lua
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

-- settings
config.default_prog = { "../../Program Files/Git/bin/bash.exe", "--login" }

config.font_size = 12
config.font = wezterm.font_with_fallback({
	-- { family = "VictorMono Nerd Font Mono", scale = 1.0, weight = "Bold" },
	{ family = "IosevkaTerm Nerd Font", scale = 1.0, weight = "Medium" },
	-- { family = "Maple Mono", scale = 1.0, weight = "Light" },
})

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30
config.color_scheme = "Tokyo Night (Gogh)"
-- config.color_scheme = "Rebecca (base16)"
-- config.color_scheme = "Laserwave (Gogh)"
-- config.color_scheme = "Lumifoo (terminal.sexy)"
-- config.color_scheme = "Lunaria Dark (Gogh)"
-- config.color_scheme = "Jellybeans"
config.colors = {
	background = "#011628",
	cursor_bg = "#ff0000",
	cursor_border = "#ff0000",
	foreground = "#eee",
	-- foreground = "#CBE0F0",
}

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.2,
}

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
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
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
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
	{ key = "n", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
	{ key = "b", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
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
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = true

-- wezterm.on("update-status", function(window, pane)
-- 	-- Workspace name
-- 	local stat = window:active_workspace()
-- 	local stat_color = "#e06f88"
-- 	-- It's a little silly to have workspace name all the time
-- 	-- Utilize this to display LDR or current key table name
-- 	if window:active_key_table() then
-- 		stat = window:active_key_table()
-- 		stat_color = "#7dcfff"
-- 	end
-- 	if window:leader_is_active() then
-- 		stat = "LDR"
-- 		stat_color = "#BB9AF7"
-- 	end
--
-- 	local basename = function(s)
-- 		-- Nothing a little regex can't fix
-- 		return string.gsub(s, "(.*[/\\])(.*)", "%2")
-- 	end
--
-- 	-- Current working directory
-- 	local cwd = pane:get_current_working_dir()
-- 	if cwd then
-- 		if type(cwd) == "userdata" then
-- 			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
-- 			cwd = basename(cwd.file_path)
-- 		else
-- 			-- 20230712-072601-f4abf8fd or earlier version
-- 			cwd = basename(cwd)
-- 		end
-- 	else
-- 		cwd = ""
-- 	end
--
-- 	-- Current command
-- 	local cmd = pane:get_foreground_process_name()
-- 	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
-- 	cmd = cmd and basename(cmd) or ""
--
-- 	-- Time
-- 	local date = wezterm.strftime("%a %b %d  ")
-- 	local time = wezterm.strftime("%H:%M")
--
-- 	-- Left status (left of the tab line)
-- 	window:set_left_status(wezterm.format({
-- 		{ Foreground = { Color = stat_color } },
-- 		{ Text = "  " },
-- 		{ Text = wezterm.nerdfonts.cod_layers .. "  " .. stat },
-- 		{ Text = " " },
-- 	}))
--
-- 	-- Right status
-- 	window:set_right_status(wezterm.format({
-- 		{ Foreground = { Color = "#22a4be" } },
-- 		-- { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
-- 		-- { Text = " | " },
-- 		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
-- 		"ResetAttributes",
-- 		{ Foreground = { Color = "#CBE0F0" } },
-- 		{ Text = " | " },
-- 		{ Text = wezterm.nerdfonts.cod_calendar .. "  " .. date },
-- 		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
-- 		{ Text = "  " },
-- 	}))
-- end)

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, { enabled_modules = { username = false, hostname = false } })

-- and finally, return the configuration to wezterm
return config
