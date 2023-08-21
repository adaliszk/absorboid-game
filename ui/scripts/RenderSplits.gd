extends VBoxContainer


func _ready() -> void:
	Log.info("splits:%s" % Game.level_data["splits"])
	var index = 0
	for split in Game.level_data["splits"]:
		var split_name = Game.split_names[index]
		var split_item = HBoxContainer.new()
		split_item.add_child(_get_label(split_name))
		split_item.add_child(_get_vspacer())
		split_item.add_child(_get_label(Utils.format_time(split)))
		add_child(split_item)
		add_child(HSeparator.new())
		index += 1



func _get_label(text: String) -> Label:
	var label = Label.new()
	label.add_theme_color_override("font_color", Color(0, 0, 0, 1))
	label.text = text
	return label


func _get_vspacer() -> VSeparator:
	var vspacer = VSeparator.new()
	vspacer.add_theme_stylebox_override("separator", StyleBoxEmpty.new())
	vspacer.size_flags_horizontal = SIZE_EXPAND
	return vspacer

