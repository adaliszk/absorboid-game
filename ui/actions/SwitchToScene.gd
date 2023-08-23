extends Button

enum Scene {
	Main,
	Settings,
	LevelSelect,
	LevelLoader,
	LevelResult,
	Sandbox,
}

const SceneFiles = [
	"res://scenes/Main.tscn",
	"res://scenes/Settings.tscn",
	"res://scenes/LevelSelect.tscn",
	"res://scenes/LevelLoader.tscn",
	"res://scenes/LevelResult.tscn",
	"res://game/Sandbox.tscn",
]

@export var scene: Scene = Scene.Main


func _pressed() -> void:
	SoundManager.play("Click")
	get_tree().change_scene_to_file(SceneFiles[scene])
