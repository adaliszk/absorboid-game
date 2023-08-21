extends Button

@export var level: LevelLoader.Level = LevelLoader.Level.lv0_tutorial


func _pressed() -> void:
	LevelManager.load_level(level)
