extends VBoxContainer


func _ready() -> void:
	Log.info("splits:%s" % Game.level_data["splits"])
	var index = 0
	for split in Game.level_data["splits"]:
		var split_name = Game.split_names[index]
		var label = Label.new()
		label.add_theme_color_override("font_color", Color(0, 0, 0, 1))
		label.text = "%s: %s" % [split_name, Utils.format_time(split)]
		add_child(label)
		index += 1
