local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = require("keybinds")

-- Basic configs
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font_with_fallback({
	"GeistMono Nerd Font",
	"JetBrains Mono",
})
config.font_size = 16
config.scrollback_lines = 50000

-- Window configs
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "1.5cell",
	right = "1.5cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

-- Command palette configs
config.command_palette_font_size = 20
config.command_palette_rows = 10

-- Tab configs
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
require("tabline") -- tabline set up

-- Hyperlink rules
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

return config
