extends Button

@export var level: LevelManager.Level = LevelManager.Level.lv0_tutorial


func _pressed() -> void:
	Game.last_scene = get_tree().get_current_scene().scene_file_path
	LevelManager.load_level(level)
