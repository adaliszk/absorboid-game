@tool
extends PanelContainer

var direction: TooltipBubble.Direction:
	get:
		return get_parent().direction

var arrow_size: int:
	get:
		return get_parent().ARROW_SIZE

# region: Lifecycle

func _ready() -> void:
	get_parent().direction_changed.connect(func(): draw.emit())


func _draw() -> void:
	var color = Color(0, 0, 0)

	match direction:
		TooltipBubble.Direction.TOP:
			_draw_bottom(color)
		TooltipBubble.Direction.BOTTOM:
			_draw_top(color)
		TooltipBubble.Direction.LEFT:
			_draw_right(color)
		TooltipBubble.Direction.RIGHT:
			_draw_left(color)

# endregion

# region: Helpers

func _draw_top(color: Color) -> void:
	draw_polygon([
		Vector2(size.x / 2, -arrow_size),
		Vector2((size.x / 2) + arrow_size, 0),
		Vector2((size.x / 2) - arrow_size, 0),
	], [color, color, color])


func _draw_right(color: Color) -> void:
	draw_polygon([
		Vector2(size.x + arrow_size, size.y / 2),
		Vector2(size.x, (size.y / 2) + arrow_size),
		Vector2(size.x, (size.y / 2) - arrow_size),
	], [color, color, color])


func _draw_bottom(color: Color) -> void:
	draw_polygon([
		Vector2(size.x / 2, size.y + arrow_size),
		Vector2((size.x / 2) + arrow_size, size.y),
		Vector2((size.x / 2) - arrow_size, size.y),
	], [color, color, color])


func _draw_left(color: Color) -> void:
	draw_polygon([
		Vector2(0 - arrow_size, size.y / 2),
		Vector2(0, (size.y / 2) + arrow_size),
		Vector2(0, (size.y / 2) - arrow_size),
	], [color, color, color])

# endregion
