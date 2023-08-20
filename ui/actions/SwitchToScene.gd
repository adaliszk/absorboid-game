extends Button

enum Scene {
	Main,
	LevelSelect,
	Settings,
}

const SceneFiles = [
	"res://scenes/Main.tscn",
	"res://scenes/LevelSelect.tscn",
	"res://scenes/Settings.tscn",
]

@export var scene: Scene = Scene.Main


func _pressed() -> void:
	Game.last_scene = get_tree().get_current_scene().scene_file_path
	get_tree().change_scene_to_file(SceneFiles[scene])
