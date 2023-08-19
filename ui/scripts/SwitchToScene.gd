extends Button

@export var scene: String = "Main"


func _pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % scene)
