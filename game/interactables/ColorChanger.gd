@tool
extends Area2D

@export var color: Game.ColorIndex = Game.ColorIndex.Default:
	set(value):
		color = value
		visible = color != Game.ColorIndex.Default
		update_collision_group()
		update_platform_sprite()
		update_sprite_color()

@onready var platform: Sprite2D = $Platform
@onready var charge: AnimatedSprite2D = $Charge

var has_charge: bool = true:
	set(value):
		Log.debug("has_charge:%s" % value)
		if charge != null:
			charge.play("spawn" if value else "consume")
		has_charge = value

var color_name: String:
	get:
		return Game.ColorName[color]

var platform_texture = [
	preload("res://game/assets/color_changer1.tres"),
	preload("res://game/assets/color_changer2.tres"),
	preload("res://game/assets/color_changer3.tres"),
	preload("res://game/assets/color_changer4.tres"),
]

# region: Lifecycle

func _ready() -> void:
	if Engine.is_editor_hint():
		update_configuration_warnings()
	body_entered.connect(on_body_entered.bind(self))
	charge.play("idle")
	update_collision_group()
	update_platform_sprite()
	update_sprite_color()


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


func update_sprite_color() -> void:
	if charge == null:
		return
	platform.modulate = Game.ColorValue[color]
	charge.modulate = Game.ColorValue[color]


func update_platform_sprite() -> void:
	if platform == null or color == Game.ColorIndex.Default:
		return
	platform.texture = platform_texture[color - 1]

# endregion

# region Events

func on_body_entered(body: Node2D, _event) -> void:
	Log.debug("has_charge:%s, body:%s" % [has_charge, body])
	if not has_charge or color == Game.ColorIndex.Default:
		return
	if body is Player and body.color_index != color:
		SoundManager.play("Color%s" % color)
		body.switch_color(color)
		body.connect("color_change", func(_old, _new, _event): has_charge = true, CONNECT_ONE_SHOT)
		has_charge = false

# endregion
