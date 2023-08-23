extends Button

@export var level: LevelLoader.Level = LevelLoader.Level.lv0_tutorial


func _pressed() -> void:
	SoundManager.play("Click")
	LevelLoader.load_level(level)
