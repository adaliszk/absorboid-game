extends Label

var template: String
var pattern: RegEx:
	get:
		if pattern != null:
			return pattern
		var regex = RegEx.new()
		regex.compile("\\{([a-z:_]+)\\}")
		return regex

var data = {
	"game_title": ProjectSettings.get_setting("application/config/name"),
	"git_version": _git_version,
	"loader_tip": LevelLoader.get_tip,
	"input:move_left": _keycode_name(KeyMapping.input["MOVE_LEFT"]),
	"input:move_right": _keycode_name(KeyMapping.input["MOVE_RIGHT"]),
	"input:move_up": _keycode_name(KeyMapping.input["MOVE_UP"]),
	"input:move_down": _keycode_name(KeyMapping.input["MOVE_DOWN"]),
	"input:move_jump": _keycode_name(KeyMapping.input["MOVE_JUMP"]),
	"input:move_dash": _keycode_name(KeyMapping.input["MOVE_DASH"]),
	"level_name": func(): return Game.level_name,
	"stage_name": func(): return Game.stage_name,
	"level_stopwatch": _level_stopwatch,
	"level:best_possible": _level_data("best_possible"),
	"level:best_time": _level_data("best_time"),
	"level:time": _level_data("time"),
}

@export var update_on_ready = true
@export var update_on_physics_process = false
@export var update_on_process = false

# region: Lifecycle

func _ready() -> void:
	template = self.text
	if update_on_ready:
		render()


func _physics_process(_delta: float) -> void:
	if update_on_physics_process:
		render()


func _process(_delta) -> void:
	if update_on_process:
		render()

# endregion

# region: Internal Helpers

func _keycode_name(keycode: int) -> Callable:
	return func(): return OS.get_keycode_string(keycode)


func _git_version() -> String:
	if Git.Build != null:
		return "%s#%s" % ["DEBUG" if OS.is_debug_build() else "RELEASE", Git.Build]
	return "#%s" % [Git.Commit]


func _level_data(prop: String) -> Callable:
	return func():
		if (prop in Game.level_data) == false:
			return "N/A"
		return Utils.format_time(Game.level_data[prop])


func _level_stopwatch() -> String:
	var time = Game.level_controller.stopwatch
	time = time if time != null else 0.0
	return Utils.format_time(time)


# endregion

# region: Actions

func render() -> void:
	for result in pattern.search_all(template):
		var key = result.get_string(1)
		if not data.has(key):
			continue
		var value = data[key]
		if value is Callable:
			value = value.call()
		Log.verbose("Found:{%s}, Value:%s" % [key, value])
		self.text = template.replace("{%s}" % key, value)

# endregion
