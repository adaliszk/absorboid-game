@tool
extends Area2D


# region: Lifecycle

func _ready() -> void:
	if Engine.is_editor_hint():
		update_configuration_warnings()


func _enter_tree() -> void:
	if Engine.is_editor_hint():
		update_configuration_warnings()


func _notification(what):
	match what:
		NOTIFICATION_PARENTED, NOTIFICATION_UNPARENTED:
			update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.get_children_configuration_warnings(self)

# endregion
