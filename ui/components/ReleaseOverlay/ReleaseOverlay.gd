extends MarginContainer

func _ready() -> void:
	get_tree().get_root().size_changed.connect(func(): update_margin())
	update_margin()


func update_margin() -> void:
	if get_viewport_rect().size.x > 960:
		add_theme_constant_override("theme_override_constants.margin_right", 12)
		return

	if OS.get_name() == "Web":
		add_theme_constant_override("theme_override_constants.margin_right", 48)
		Log.debug("Web detected in embedded mode, setting margin right to 48px")
