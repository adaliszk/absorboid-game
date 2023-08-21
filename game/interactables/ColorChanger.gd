@tool
extends Area2D

@export var color: Game.ColorIndex = Game.ColorIndex.Default:
	set(value):
		color = value
		color_name = Game.ColorName[value]
		update_collision_group()

var color_name: String = "Default"

# region: Lifecycle

func _ready() -> void:
	if Engine.is_editor_hint():
		update_configuration_warnings()
	body_entered.connect(on_body_entered.bind(self))


func _notification(what):
	match what:
		NOTIFICATION_PARENTED, NOTIFICATION_UNPARENTED:
			update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.get_children_configuration_warnings(self)

# endregion

# region Actions

func update_collision_group() -> void:
	collision_layer = color if color != Game.ColorIndex.Default else 5
	collision_mask = color if color != Game.ColorIndex.Default else 5

# endregion

# region Events

func on_body_entered(body: Node2D, _event) -> void:
	Log.debug("body:%s" % body)
	if "switch_color" in body:
		body.switch_color(color)

# endregion
