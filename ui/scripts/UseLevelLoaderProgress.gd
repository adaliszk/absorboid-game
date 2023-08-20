extends ProgressBar

func _ready() -> void:
	LevelManager.progress.connect(func(state: float): value = state)
