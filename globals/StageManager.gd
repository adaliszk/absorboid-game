class_name StageManager
extends Container

const end_screen = preload("res://scenes/LevelResult.tscn")

var stage_scenes: Array = []
var current_stage: Node2D
var stage_index: int = -1

# region: Lifecycle

func _ready() -> void:
	stage_scenes = owner.stages if "stages" in owner else []
	Game.level_name = owner.name
	next_stage()

# endregion

# region: Actions

func next_stage() -> void:
	Game.level_controller.stopwatch_enabled = false
	stage_index += 1

	if current_stage:
		remove_child(current_stage)

	if stage_index >= stage_scenes.size():
		get_tree().change_scene_to_packed(end_screen)
		Game.level_controller.done()
		return

	current_stage = stage_scenes[stage_index].instantiate()
	Game.stage_name = current_stage.name
	add_child(current_stage)

	# Continue the Stopwatch if it was running
	if Game.level_controller.stopwatch > 0.0:
		Game.level_controller.stopwatch_enabled = true

	Game.level_controller.split()

	current_stage.stage_success.connect(func(): next_stage())
	current_stage.stage_failure.connect(func(): reset_stage())


func reset_stage() -> void:
	stage_index -= 1
	next_stage()

# endregion
