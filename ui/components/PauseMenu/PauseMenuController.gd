extends Control

signal drawer_toggled(state: bool)


@export var opened: bool = false:
	set(value):
		opened = value
		get_tree().paused = value
		render()


@onready var drawer: PanelContainer = $Drawer


var drawer_position: float

# region: Lifecycle

func _ready() -> void:
	drawer_position = -drawer.size.x
	drawer.position.x = drawer_position
	drawer_toggled.connect(_drawer_toggle)


func _process(_delta) -> void:
	drawer.position.x = lerp(drawer.position.x, drawer_position, 0.2)
	if drawer.position.x <= -drawer.size.x and drawer.visible:
		drawer_toggled.emit(opened)


func _exit_tree():
	get_tree().paused = false


func _drawer_toggle(state: bool) -> void:
	Log.debug("visible:%s" % state)
	drawer.visible = state

# endregion

# region: Actions

func toggle() -> void:
	opened = not opened
	Log.info("opened:%s" % opened)
	if opened:
		drawer.visible = true


func render() -> void:
	if drawer == null:
		return
	drawer_position = 0.0 if opened else -drawer.size.x

# endregion
