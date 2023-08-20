class_name Traits
extends Node


static func get_children_configuration_warnings(node: Node) -> PackedStringArray:
	if not Engine.is_editor_hint():
		return []

	var shared_warnings: PackedStringArray = []
	for child in node.get_children(true):
		if child is Control and "_get_configuration_warnings" in child:
			var warnings = child._get_configuration_warnings()
			shared_warnings.append_array(warnings)

	return shared_warnings
