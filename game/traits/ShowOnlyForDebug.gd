extends Control


func _ready():
	get_parent().visible = OS.is_debug_build()
