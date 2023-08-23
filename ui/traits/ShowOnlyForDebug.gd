extends CanvasLayer

func _ready() -> void:
	visible = OS.is_debug_build()
