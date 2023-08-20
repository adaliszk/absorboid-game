class_name Game
extends Node

enum ColorIndex { Default, Color1, Color2, Color3, Color4 }

const ColorName = ["Default", "Color1", "Color2", "Color3", "Color4"]
static var ColorValue = [
	ProjectSettings.get_setting("game/config/default_color"),
	ProjectSettings.get_setting("game/config/color1"),
	ProjectSettings.get_setting("game/config/color2"),
	ProjectSettings.get_setting("game/config/color3"),
	ProjectSettings.get_setting("game/config/color4"),
]
