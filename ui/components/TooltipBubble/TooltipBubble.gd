@tool
class_name TooltipBubble
extends MarginContainer

signal direction_changed

enum Direction { TOP, RIGHT, BOTTOM, LEFT }

const ARROW_SIZE: int = 8

@export var offset: float = 0.0:
	set(value):
		offset = value
		update_tooltip()

@export var tooltip: String = "{tooltip}":
	set(value):
		tooltip = value
		update_tooltip()

@export var direction: Direction = Direction.TOP:
	set(value):
		direction = value
		direction_changed.emit()
		update_tooltip()

@onready var container: PanelContainer = $Bubble
@onready var content: RichTextLabel = $Bubble/Content

# region: Lifecycle

func _ready() -> void:
	tree_entered.connect(func(): update_tooltip())
	update_tooltip()


# endregion

# region: Actions

func update_tooltip(text: String = "") -> void:
	update_content(text)
	update_spacing()


func update_content(text: String = "") -> void:
	if content == null:
		return
	content.text = "[center]%s[/center]" % text if text != "" else tooltip


func update_spacing() -> void:
	if content == null:
		return

	# Dynamically get the size of the container
	var height = ceili(container.size.y) * 2
	var width = ceili(container.size.x) * 2

	# Reset all margins
	for constant in ["margin_top", "margin_right", "margin_bottom", "margin_left"]:
		remove_theme_constant_override(constant)
	for anchor in ["anchor_top", "anchor_right", "anchor_bottom", "anchor_left"]:
		set(anchor, 0)

	# Set margins based on the direction
	match direction:
		Direction.TOP:
			add_theme_constant_override("margin_bottom", height + offset + ARROW_SIZE)
			anchor_bottom = 1
		Direction.RIGHT:
			add_theme_constant_override("margin_left", width + offset + ARROW_SIZE)
			anchor_right = 1
		Direction.BOTTOM:
			add_theme_constant_override("margin_top", height - offset + ARROW_SIZE)
			anchor_top = 1
		Direction.LEFT:
			add_theme_constant_override("margin_right", width - offset + ARROW_SIZE)
			anchor_left = 1

# endregion
