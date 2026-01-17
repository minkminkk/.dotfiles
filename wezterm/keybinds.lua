local wezterm = require("wezterm")
local act = wezterm.action
local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

-- Workspace switcher
local dir_to_select_projects = "/Users/.*/Desktop/code/"
local my_schema = {
	options = {
		title = "Select workspace",
		prompt = "Select workspace: ",
	},
	{
		sessionizer.DefaultWorkspace({}),
		sessionizer.AllActiveWorkspaces({}),
		sessionizer.FdSearch({
			wezterm.home_dir .. "/Desktop/code",
			fd_path = "/opt/homebrew/bin/fd",
			max_depth = 3,
			exclude = { "node_modules", ".venv" },
		}), -- git repos in the folder

		processing = sessionizer.for_each_entry(function(entry)
			entry.label = wezterm.format({
				{ Text = "󱂬 : " .. string.gsub(entry.label, dir_to_select_projects, "") },
			})
		end),
	},
}

return {
	-- macOS movement
	-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({ key = "b", mods = "ALT" }),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
	{
		key = "LeftArrow",
		mods = "SUPER",
		action = act.SendString("\x1bOH"),
	},
	{
		key = "RightArrow",
		mods = "SUPER",
		action = act.SendString("\x1bOF"),
	},
	{
		key = "Backspace",
		mods = "SUPER",
		action = act.SendString("\x15"),
	},
	-- iterm2-like tab management
	{
		key = "t",
		mods = "CMD",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "d",
		mods = "SUPER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "[",
		mods = "SUPER",
		action = act.ActivatePaneDirection("Prev"),
	},
	{
		key = "]",
		mods = "SUPER",
		action = act.ActivatePaneDirection("Next"),
	},
	{
		key = "k",
		mods = "SUPER",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},

	-- Scrollback search
	{
		key = "f",
		mods = "SUPER",
		action = act.Search({ CaseInSensitiveString = "" }),
	},
	{
		key = "p",
		mods = "SUPER | SHIFT",
		action = act.ActivateCommandPalette,
	},
	{
		key = "p",
		mods = "CTRL | SHIFT",
		action = act.DisableDefaultAssignment,
	},

	-- Sessionizer functionality
	{
		key = "o",
		mods = "SUPER|SHIFT",
		action = sessionizer.show(my_schema),
	},
}
