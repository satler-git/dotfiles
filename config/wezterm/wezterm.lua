local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- カラースキームの設定
config.color_scheme = "Aura (Gogh)"

-- 背景透過
config.window_background_opacity = 1

-- 最初からフルスクリーンで起動
local mux = wezterm.mux

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
	-- Alt(Opt)+Shift+Fでフルスクリーン切り替え
	{
		key = "f",
		mods = "SHIFT|META",
		action = wezterm.action.ToggleFullScreen,
	},
}

-- フォントの設定
wezterm.font("Monaspace Argon", { weight = "Regular", stretch = "SemiExpanded", style = "Normal" })
-- wezterm.font("Monaspace Argon", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- wezterm.font("Fira Code", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- wezterm.font("Firge35Nerd Console", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- wezterm.font("FirgeNerd Console", {weight="Regular", stretch="Normal", style="Normal"})

config.font = wezterm.font_with_fallback({
	"Fira Code",
})

-- フォントサイズの設定
config.font_size = 12

-- shell
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }

config.enable_scroll_bar = true

return config
