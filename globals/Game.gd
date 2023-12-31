extends Node


signal settings_loaded(settings: Dictionary)


enum ColorIndex { Default, DoubleJump, Dash, Sticky, Float }

const SETTINGS_FILE = "user://settings.json"

const ColorName = ["Default", "DoubleJump", "Dash", "Sticky", "Float"]
var ColorValue = [
	ProjectSettings.get_setting("game/config/default_color"),
	ProjectSettings.get_setting("game/config/color1"),
	ProjectSettings.get_setting("game/config/color2"),
	ProjectSettings.get_setting("game/config/color3"),
	ProjectSettings.get_setting("game/config/color4"),
]

var settings: Dictionary = {}

var level_controller: LevelController = null
var level_data: Dictionary = {}
var level: LevelLoader.Level = LevelLoader.Level.lv0_tutorial

var level_name: String = "N/A":
	set(value):
		if level_name != value:
			split_names = []
		level_name = value

var stage_name: String = "N/A":
	set(value):
		split_names.append(value)
		stage_name = value

var split_names: PackedStringArray = []


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
	settings_loaded.emit(settings)

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
