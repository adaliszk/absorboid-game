extends Node

enum ColorIndex { Default, Color1, Color2, Color3, Color4 }

const SETTINGS_FILE = "user://settings.json"

const ColorName = ["Default", "Color1", "Color2", "Color3", "Color4"]
var ColorValue = [
	ProjectSettings.get_setting("game/config/default_color"),
	ProjectSettings.get_setting("game/config/color1"),
	ProjectSettings.get_setting("game/config/color2"),
	ProjectSettings.get_setting("game/config/color3"),
	ProjectSettings.get_setting("game/config/color4"),
]

var level_controller: LevelController = null
var level_name: String = "N/A"
var stage_name: String = "N/A"


var settings = {}


# region: Lifecycle

func _ready() -> void:
	var json = JSON.new()

	if FileAccess.file_exists(SETTINGS_FILE):
		Log.info("Saved settings found, parsing...")
		var settings_handler = FileAccess.open(SETTINGS_FILE, FileAccess.READ)
		json.parse(settings_handler.get_as_text())
		settings = json.get_data()
		Log.debug("Parsed:%s" % settings)
		settings_handler.close()

	if "keyboard_layout" in settings:
		Log.debug("Keyboard Layout found in settings, applying...")
		KeyMapping.current = settings["keyboard_layout"] as KeyMapping.Type


func _exit_tree() -> void:
	save()

# endregion

# region: Actions

func save() -> void:
	var settings_handler = FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	settings_handler.store_string(JSON.stringify(Game.settings))
	settings_handler.close()

# endregion
