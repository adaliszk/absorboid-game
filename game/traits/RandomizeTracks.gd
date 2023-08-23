extends AudioStreamPlayer

@export var tracks: Array

# region: Lifecycle

func _ready() -> void:
	finished.connect(func(): _finished())
	pick_track()


func _finished() -> void:
	pick_track()

# endregion

# region: Actions

func pick_track() -> void:
	var selected = tracks[randi() % tracks.size()]
	var audio = load("res://sounds/%s.ogg" % selected)
	Log.debug("audio:%s" % audio)
	stream = audio

# endregion
