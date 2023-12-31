class_name Player
extends CharacterBody2D

signal color_change(old: Game.ColorIndex, new: Game.ColorIndex)
signal dash(direction: Vector2)
signal jump(direction: Vector2)
signal double_jump(direction: Vector2)
signal stick(direction: Vector2)

const SPEED: float = 400.0
const JUMP_VELOCITY: float = -600.0

const DASH_FALLOFF: float = 100.0
const DASH_ENERGY: float = 800.0

const STICKY_GRAVITY = 150.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var color_index: Game.ColorIndex = Game.ColorIndex.Default:
	set(value):
		if sprite != null:
			sprite.modulate = Game.ColorValue[value]
		emit_signal("color_change", color_index, value)
		color_index = value

var color_name: String:
	get:
		return Game.ColorName[color_index]

var color: Color = Color(1.0, 1.0, 1.0, 1.0):
	get:
		return Game.ColorValue[color_index]

var move_velocity: Vector2 = Vector2.ZERO
var dash_direction: float = 0.0
var dash_energy: float = 0.0

var should_be_sticky: bool = false
var is_sticked: bool = false:
	get:
		return should_be_sticky and is_on_wall()

@onready var sprite: Sprite2D = $Sprite

# region: Lifecycle

func _ready() -> void:
	switch_color(Game.ColorIndex.Default)


func _physics_process(delta) -> void:
	should_be_sticky = is_on_wall()
	apply_gravity(delta)

	sprite.flip_h = velocity.x < 0.0

	dash_energy -= DASH_FALLOFF
	dash_energy = dash_energy if dash_energy > 0.0 else 0.0
	move_and_slide()

func _input(event) -> void:
	handle_inputs(event)

# endregion

# region: Actions

func switch_color(index: Game.ColorIndex) -> void:
	Log.debug("switch_color:%s" % index)
	color_index = index
	# TODO: Change sprite color
	var bit = 2 ** (index - 1)
	collision_mask = 16 | bit


func handle_inputs(event) -> void:
	# JUMP and DOUBLE-JUMP Action
	if event is InputEventKey and KeyMapping.is_jump_pressed(event):
		if is_on_floor() or is_sticked:
			velocity.y = JUMP_VELOCITY
			SoundManager.play("Jump")
			jump.emit(velocity)
		elif color_index == Game.ColorIndex.DoubleJump:
			switch_color(Game.ColorIndex.Default)
			velocity.y = JUMP_VELOCITY
			SoundManager.play("DoubleJump")
			double_jump.emit(velocity)

	# MOVE Action
	var direction = KeyMapping.get_vector().normalized()
	move_velocity = direction * SPEED if direction else Vector2.ZERO

	# DASH Action
	if event is InputEventKey and KeyMapping.is_dash_pressed(event):
		if color_index != Game.ColorIndex.Dash:
			return
		Log.debug("dash:%s" % direction)
		switch_color(Game.ColorIndex.Default)
		dash_direction = direction.x
		dash_energy = DASH_ENERGY
		SoundManager.play("Dash")
		dash.emit(velocity + Vector2(dash_energy * dash_direction, 0))
		velocity.y = gravity * -0.25

	velocity.x = move_velocity.x + dash_energy * dash_direction


func apply_gravity(delta) -> void:
	if not is_on_floor():
		if should_be_sticky and color_index == Game.ColorIndex.Sticky:
			velocity.y = velocity.y if velocity.y < 0.0 else 0.0
			return
		velocity.y += gravity * delta

# endregion
