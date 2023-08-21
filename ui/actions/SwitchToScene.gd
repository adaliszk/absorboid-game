extends Button

enum Scene {
	Main,
	LevelSelect,
	Settings,
	LevelResult,
	Sandbox,
}

const SceneFiles = [
	"res://scenes/Main.tscn",
	"res://scenes/LevelSelect.tscn",
	"res://scenes/Settings.tscn",
	"res://scenes/LevelResult.tscn",
	"res://game/Sandbox.tscn",
]

@export var scene: Scene = Scene.Main


func _pressed() -> void:
	get_tree().change_scene_to_file(SceneFiles[scene])
