extends Button

func _pressed() -> void:
	SoundManager.play("Click")
	get_tree().reload_current_scene()
