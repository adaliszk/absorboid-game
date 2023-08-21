extends Control


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


func _process(_delta) -> void:
	drawer.position.x = lerp(drawer.position.x, drawer_position, 0.2)


func _exit_tree():
	get_tree().paused = false

# endregion

# region: Actions

func toggle() -> void:
	opened = not opened
	Log.info("opened:%s" % opened)


func render() -> void:
	if drawer == null:
		return
	drawer_position = 0.0 if opened else -drawer.size.x

# endregion
