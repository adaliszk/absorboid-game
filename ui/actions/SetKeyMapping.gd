extends OptionButton

signal item_applied


# region: Lifecycle

func _ready() -> void:
	for option in KeyMapping.Type.keys():
		add_item(option)

	item_selected.connect(func(index): _on_selected(index))

# endregion

# region: Events

func _on_selected(index) -> void:
	KeyMapping.current = index as KeyMapping.Type
	item_applied.emit()

# endregion
