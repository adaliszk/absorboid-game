class_name KeyMapping
extends Node

signal mapping_changed


enum Type { QWERTY, AZERTY }

const presets = [
	{
		"MOVE_LEFT": KEY_A,
		"MOVE_RIGHT": KEY_D,
		"MOVE_UP": KEY_W,
		"MOVE_DOWN": KEY_S,
		"MOVE_JUMP": KEY_SPACE,
		"MOVE_DASH": KEY_SHIFT,
	},
	{
		"MOVE_LEFT": KEY_Q,
		"MOVE_RIGHT": KEY_D,
		"MOVE_UP": KEY_Z,
		"MOVE_DOWN": KEY_S,
		"MOVE_JUMP": KEY_SPACE,
		"MOVE_DASH": KEY_SHIFT,
	}
]

static var current: Type = Type.QWERTY
static var input: Dictionary:
	get:
		return presets[current]

static func get_vector() -> Vector2:
	var right = 1.0 if Input.is_key_pressed(input["MOVE_RIGHT"]) else 0.0
	var left = 1.0 if Input.is_key_pressed(input["MOVE_LEFT"]) else 0.0
	var up = 1.0 if Input.is_key_pressed(input["MOVE_UP"]) else 0.0
	var down = 1.0 if Input.is_key_pressed(input["MOVE_DOWN"]) else 0.0
	return Vector2(right - left, down - up)

static func is_jump_pressed(event: InputEventKey) -> bool:
	return event.keycode == input["MOVE_JUMP"] and event.pressed and not event.echo

static func is_dash_pressed(event: InputEventKey) -> bool:
	return event.keycode == input["MOVE_DASH"] and event.pressed and not event.echo
