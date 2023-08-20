@tool
class_name TilemapGizmo
extends Control

var map: TileMap


func _ready() -> void:
	get_parent().tree_entered.connect(func(): check_map())
	check_map()


func _get_configuration_warnings() -> PackedStringArray:
	if not map is TileMap:
		return ["This node needs to be a child of a `TileMap` to work properly."]
	return []


func _physics_process(_delta):
	if Engine.is_editor_hint() and map:
		get_parent().position = map.map_to_local(map.local_to_map(get_parent().position))


func check_map() -> void:
	map = get_parent().get_parent() if get_parent().get_parent() is TileMap else null


func map_to_local(pos: Vector2) -> Vector2:
	return map.map_to_local(pos)


func local_to_map(pos: Vector2) -> Vector2:
	return map.local_to_map(pos)
