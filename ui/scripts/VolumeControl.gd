extends HSlider

@export_enum("Music", "Effect", "UI", "Master") var channel: int = 3


func _ready():
	value = SoundManager.get_volume(channel) * 100


func _value_changed(new_value):
	SoundManager.set_volume(channel, new_value / 100)
