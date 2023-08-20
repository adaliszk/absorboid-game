@tool
extends Control

@export var content: Node
@export var target: Node

# region: Lifecycle

func _ready() -> void:
	var nested_target = get_parent().get_parent()
	target = nested_target if nested_target is Node else null
	var nested_content = get_parent()
	content = nested_content if nested_content is TooltipBubble else null
	update_parent_content()


func _physics_process(_delta) -> void:
	update_parent_content()

# endregion

# region: Actions

func update_parent_content() -> void:
	if target == null:
		return

	var debug_content = ""
	for child in get_children():
		if child.name in target:
			var property = target[child.name]
			debug_content += "%s=%s\n" % [child.name, property]
	content.update_content(debug_content)

# endregion
