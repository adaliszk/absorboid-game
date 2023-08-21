extends OptionButton

signal item_applied


# region: Lifecycle

func _ready() -> void:
	for option in KeyMapping.Type.keys():
		add_item(option)
	select(KeyMapping.current)

# endregion

# region: Events

func _on_selected(index) -> void:
	Log.info("selected:%s" % index)
	KeyMapping.current = index as KeyMapping.Type
	item_applied.emit()

# endregion
