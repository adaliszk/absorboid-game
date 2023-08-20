extends MarginContainer

func _ready() -> void:
	if OS.get_name() == "Web":
		add_theme_constant_override("theme_override_constants.margin_right", 48)
