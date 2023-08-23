extends Control

enum Channel { Music, Effects, UI, Master }
enum Music { Menu, Gameplay }

@export_range(0.0, 1.0) var master_volume: float = 0.5:
	set(value):
		master_volume = value
		music_volume = music_volume
		effects_volume = effects_volume
		ui_volume = ui_volume

@export_range(0.0, 1.0) var music_volume: float = 0.5:
	set(value):
		music_volume = value
		if music != null:
			for player in music.get_children():
				player.volume_db = _volume_to_db(value)

@export_range(0.0, 1.0) var effects_volume: float = 0.5:
	set(value):
		effects_volume = value
		if effects != null:
			for player in effects.get_children():
				player.volume_db = _volume_to_db(value)

@export_range(0.0, 1.0) var ui_volume: float = 0.5:
	set(value):
		ui_volume = value
		if ui != null:
			for player in ui.get_children():
				player.volume_db = _volume_to_db(value)

@onready var music: Control = $Music
@onready var effects: Control = $Effects
@onready var ui: Control = $UI

var music_crossfade1: AudioStreamPlayer = null
var music_crossfade2: AudioStreamPlayer = null
var music_player: AudioStreamPlayer = null

# region: Lifecycle

func _ready() -> void:
	Game.settings_loaded.connect(_init_volume.bind(self))


func _init_volume(settings: Dictionary, _event) -> void:
	set_volume(Channel.Master, settings.get("master_volume", master_volume))
	set_volume(Channel.Music, settings.get("music_volume", music_volume))
	set_volume(Channel.Effects, settings.get("effects_volume", effects_volume))
	set_volume(Channel.UI, settings.get("ui_volume", ui_volume))
	music_player = music.get_child(Music.Menu)
	music_player.play()


func _process(delta) -> void:
	if music_crossfade1 != null:
		music_crossfade1.volume_db -= delta * 40
		if music_crossfade1.volume_db <= -80:
			music_crossfade1.stop()
			music_crossfade1 = null
	if music_crossfade2 != null:
		music_crossfade2.volume_db += max(delta * 60, _volume_to_db(music_volume))
		if music_crossfade2.volume_db >= _volume_to_db(music_volume):
			music_player = music_crossfade2
			music_crossfade2 = null

# endregion

# region: Actions

func play_music(track: Music) -> void:
	music_crossfade1 = music_player
	music_crossfade2 = music.get_child(track)
	music_crossfade2.volume_db = -40
	music_crossfade2.play()


func play(sound: String) -> void:
	var audio = find_child(sound)
	if audio != null:
		audio.stop()
		audio.play()


func set_volume(channel: Channel, volume: float) -> void:
	Log.info("channel:%s, volume:%s" % [channel, volume])
	var db = _volume_to_db(volume)
	match channel:
		Channel.Effects:
			Game.settings["effects_volume"] = volume
			effects_volume = volume
			for player in effects.get_children():
				player.volume_db = db
		Channel.UI:
			Game.settings["ui_volume"] = volume
			ui_volume = volume
			for player in ui.get_children():
				player.volume_db = db
		Channel.Music:
			Game.settings["music_volume"] = volume
			music_volume = volume
		Channel.Master:
			Game.settings["master_volume"] = volume
			master_volume = volume


func get_volume(channel: Channel) -> float:
	Log.info("channel:%s" % channel)
	match channel:
		Channel.Music:
			return music_volume
		Channel.Effects:
			return effects_volume
		Channel.UI:
			return ui_volume
	return master_volume

# endregion

# region: Helpers

func _volume_to_db(volume: float) -> float:
	var scaled_volume = (master_volume * volume) * 2
	return 20 * log(scaled_volume) / log(10)

# endregion

