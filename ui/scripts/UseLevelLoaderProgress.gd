extends ProgressBar

func _ready() -> void:
	LevelLoader.progress.connect(func(state: float): value = state)
