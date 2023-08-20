extends Node

signal progress(value: float)
signal error(message: String)
signal loaded

enum Status {
	THREAD_LOAD_INVALID_RESOURCE,
	THREAD_LOAD_IN_PROGRESS,
	THREAD_LOAD_FAILED,
	THREAD_LOAD_LOADED,
}

enum Level {
	lv0_tutorial,
}

const TIPS = [
	"Locating the required gigapixels to render...",
	"Spinning up the hamster...",
	"Programming the flux capacitor...",
]

var target_level: String = "res://scenes/Main.tscn"
var is_loading: bool = false

# region: Lifecycle

func _process(_delta: float) -> void:
	if is_loading == false:
		return
	var threads = []
	var status = ResourceLoader.load_threaded_get_status(target_level, threads)
	Log.debug("Threaded load: %s" % [Status.keys()[status]])

	if status == Status.THREAD_LOAD_IN_PROGRESS:
		var sum = threads.reduce(func(accum, number): return accum + number, 0.0)
		Log.debug("Threaded load progress: %s" % [sum])
		progress.emit(sum)

	if status == Status.THREAD_LOAD_LOADED:
		is_loading = false
		progress.emit(1.0)
		Log.info("Threaded load completed!")
		var scene = ResourceLoader.load_threaded_get(target_level)
		get_tree().change_scene_to_packed(scene)

# endregion

# region: Actions

func load_level(level: Level) -> void:
	get_tree().change_scene_to_file("res://scenes/LevelLoader.tscn")
	var level_name = Level.keys()[level]
	target_level = "res://levels/%s/%s.tscn" % [level_name, level_name]
	ResourceLoader.load_threaded_request(target_level)
	progress.emit(0.0)
	is_loading = true

func get_tip() -> String:
	return TIPS[randi() % TIPS.size()]

# endregion
