extends Label

var template: String
var pattern: RegEx:
	get:
		if pattern != null:
			return pattern
		var regex = RegEx.new()
		regex.compile("\\{([a-z_]+)\\}")
		return regex

var data = {
	"game_title": ProjectSettings.get_setting("application/config/name"),
	"git_version": "Build#%s" % Git.Build if Git.Build != null else "#%s" % [Git.Commit],
	"loader_tip": LevelManager.get_tip,
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

# region: Actions

func render() -> void:
	for result in pattern.search_all(template):
		var key = result.get_string(1)
		if not data.has(key):
			continue
		var value = data[key]
		if value is Callable:
			value = value.call()
		Log.debug("Found:{%s}, Value:%s" % [key, value])
		self.text = template.replace("{%s}" % key, value)

# endregion
