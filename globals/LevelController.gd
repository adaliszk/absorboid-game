class_name LevelController
extends Node2D

@export var codeName: String = "lv0"

var stopwatch_enabled: bool = false
var stopwatch: float = 0.0
var last_split: float = 0.0
var splits: PackedFloat32Array = []
var data: Dictionary = {}

# region: Lifecycle

func _ready() -> void:
	Game.level_controller = self
	Game.level_name = name
	stopwatch = 0.0


func _process(delta) -> void:
	if stopwatch_enabled:
		stopwatch += delta


func _enter_tree() -> void:
	Game.level_controller = self
	Game.level_name = name


func _exit_tree() -> void:
	stopwatch_enabled = false
	save()
	Game.level_controller = null
	Game.level_data = data


# endregion

# region: Actions


func split() -> void:
	Log.debug("stopwatch_enabled:%s" % stopwatch_enabled)
	if not stopwatch_enabled:
		stopwatch_enabled = true
		return
	_split()


func done() -> void:
	stopwatch_enabled = false
	_split()


func save() -> void:
	var json = JSON.new()
	data = {
		"best_splits": splits,
		"best_possible": stopwatch,
		"best_run": splits,
		"best_time": stopwatch,
		"splits": splits,
		"time": stopwatch,
	}
	var file_name = "user://result-%s.json" % codeName
	if FileAccess.file_exists(file_name):
		var previous_handler = FileAccess.open(file_name, FileAccess.READ)
		json.parse(previous_handler.get_as_text())
		var previous_data = json.get_data()
		data = _merge_saves(previous_data, data)
		previous_handler.close()

	Log.debug("save_data:%s" % data)
	var data_handler = FileAccess.open(file_name, FileAccess.WRITE)
	data_handler.store_string(JSON.stringify(data))
	data_handler.close()


# endregion

# region: Internal Logic

func _split() -> void:
	splits.append(stopwatch - last_split)
	last_split = stopwatch


func _merge_saves(previous: Dictionary, current: Dictionary) -> Dictionary:
	# Carry over the best splits
	current["best_possible"] = previous["best_possible"]
	current["best_splits"] = previous["best_splits"]

	# Keep the best run if it has not been beaten
	if previous["best_time"] < current["best_time"]:
		current["best_time"] = previous["best_time"]
		current["best_run"] = previous["best_run"]

	# Keep the best splits from each stage
	var index = 0
	for best_split in previous["best_splits"]:
		var current_split = current["splits"][index]
		if best_split > current_split:
			current["best_splits"][index] = current_split
		index += 1

	# Calculate the new best possible time
	current["best_possible"] = current["best_splits"]\
		.reduce(func(accum, number): return accum + number, 0.0)

	return current


# endregion
