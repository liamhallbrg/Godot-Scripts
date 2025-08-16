extends Node

## SoundManager for 2D Shooter Game
## Handles music, sound effects, and audio settings

signal volume_changed(bus_name: String, volume: float)

# Audio buses
const MASTER_BUS = "Master"
const MUSIC_BUS = "Music" 
const SFX_BUS = "SFX"

# Audio player pools
@onready var music_player: AudioStreamPlayer
@onready var sfx_players: Array[AudioStreamPlayer] = []
@onready var positional_sfx_players: Array[AudioStreamPlayer2D] = []

# Audio resources
var music_tracks: Dictionary = {}
var sfx_sounds: Dictionary = {}

# Settings
var master_volume: float = 1.0
var music_volume: float = 0.7
var sfx_volume: float = 0.8
var max_sfx_players: int = 20
var max_positional_players: int = 10

# State
var current_music: String = ""
var is_music_paused: bool = false

func _ready():
	# Create audio bus layout if not exists
	_setup_audio_buses()
	
	# Initialize audio players
	_setup_audio_players()
	
	# Apply saved settings
	_load_audio_settings()

func _setup_audio_buses():
	"""Ensure proper audio bus setup"""
	# Check if buses exist, create if needed
	var master_idx = AudioServer.get_bus_index(MASTER_BUS)
	if master_idx == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.set_bus_name(AudioServer.bus_count - 1, MASTER_BUS)
	
	var music_idx = AudioServer.get_bus_index(MUSIC_BUS)
	if music_idx == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.set_bus_name(AudioServer.bus_count - 1, MUSIC_BUS)
		AudioServer.set_bus_send(AudioServer.bus_count - 1, MASTER_BUS)
	
	var sfx_idx = AudioServer.get_bus_index(SFX_BUS)
	if sfx_idx == -1:
		AudioServer.add_bus(AudioServer.bus_count)
		AudioServer.set_bus_name(AudioServer.bus_count - 1, SFX_BUS)
		AudioServer.set_bus_send(AudioServer.bus_count - 1, MASTER_BUS)

func _setup_audio_players():
	"""Initialize audio player pools"""
	# Music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = MUSIC_BUS
	add_child(music_player)
	
	# SFX players pool
	for i in range(max_sfx_players):
		var player = AudioStreamPlayer.new()
		player.bus = SFX_BUS
		add_child(player)
		sfx_players.append(player)
	
	# Positional SFX players pool
	for i in range(max_positional_players):
		var player = AudioStreamPlayer2D.new()
		player.bus = SFX_BUS
		add_child(player)
		positional_sfx_players.append(player)

# =============================================================================
# PUBLIC METHODS - Music Control
# =============================================================================

func play_music(track_name: String, fade_in_duration: float = 0.5):
	"""Play background music with optional fade in"""
	if not music_tracks.has(track_name):
		push_error("Music track not found: " + track_name)
		return
	
	if current_music == track_name and music_player.playing:
		return  # Already playing this track
	
	# Stop current music
	if music_player.playing:
		stop_music()
	
	# Set new track
	music_player.stream = music_tracks[track_name]
	current_music = track_name
	
	# Play with fade in
	if fade_in_duration > 0:
		music_player.volume_db = -80
		music_player.play()
		var tween = create_tween()
		tween.tween_method(_set_music_volume_db, -80.0, 0.0, fade_in_duration)
	else:
		music_player.play()

func stop_music(fade_out_duration: float = 0.5):
	"""Stop music with optional fade out"""
	if not music_player.playing:
		return
	
	if fade_out_duration > 0:
		var tween = create_tween()
		tween.tween_method(_set_music_volume_db, 0.0, -80.0, fade_out_duration)
		tween.tween_callback(music_player.stop)
	else:
		music_player.stop()
	
	current_music = ""

func pause_music():
	"""Pause current music"""
	music_player.stream_paused = true
	is_music_paused = true

func resume_music():
	"""Resume paused music"""
	music_player.stream_paused = false
	is_music_paused = false

func set_music_position(position: float):
	"""Set music playback position in seconds"""
	music_player.seek(position)

func get_music_position() -> float:
	"""Get current music position in seconds"""
	return music_player.get_playback_position()

# =============================================================================
# PUBLIC METHODS - Sound Effects
# =============================================================================

func play_sfx(sound: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> AudioStreamPlayer:
	var player = _get_available_sfx_player()
	if not player:
		return null  # All players busy
	
	player.stream = sound
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()
	
	return player

func play_sfx_at_position(sound: AudioStream, position: Vector2, volume_db: float = 0.0, pitch_scale: float = 1.0) -> AudioStreamPlayer2D:
	var player = _get_available_positional_player()
	if not player:
		return null  # All players busy
	
	player.stream = sound
	player.global_position = position
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()
	
	return player

func play_sfx_random_pitch(sound: AudioStream, min_pitch: float = 0.8, max_pitch: float = 1.2, volume_db: float = 0.0) -> AudioStreamPlayer:
	var random_pitch = randf_range(min_pitch, max_pitch)
	return play_sfx(sound, volume_db, random_pitch)

func play_sfx_random_pitch_at_position(sound: AudioStream, position: Vector2, min_pitch: float = 0.8, max_pitch: float = 1.2, volume_db: float = 0.0) -> AudioStreamPlayer2D:
	var random_pitch = randf_range(min_pitch, max_pitch)
	return play_sfx_at_position(sound, position, volume_db, random_pitch)

func stop_all_sfx():
	for player in sfx_players:
		if player.playing:
			player.stop()
	
	for player in positional_sfx_players:
		if player.playing:
			player.stop()

# =============================================================================
# PUBLIC METHODS - Volume Control
# =============================================================================

func set_master_volume(volume: float):
	"""Set master volume (0.0 to 1.0)"""
	master_volume = clamp(volume, 0.0, 1.0)
	var volume_db = linear_to_db(master_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MASTER_BUS), volume_db)
	volume_changed.emit(MASTER_BUS, master_volume)

func set_music_volume(volume: float):
	"""Set music volume (0.0 to 1.0)"""
	music_volume = clamp(volume, 0.0, 1.0)
	var volume_db = linear_to_db(music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS), volume_db)
	volume_changed.emit(MUSIC_BUS, music_volume)

func set_sfx_volume(volume: float):
	"""Set SFX volume (0.0 to 1.0)"""
	sfx_volume = clamp(volume, 0.0, 1.0)
	var volume_db = linear_to_db(sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(SFX_BUS), volume_db)
	volume_changed.emit(SFX_BUS, sfx_volume)

func get_master_volume() -> float:
	return master_volume

func get_music_volume() -> float:
	return music_volume

func get_sfx_volume() -> float:
	return sfx_volume

# =============================================================================
# PRIVATE METHODS
# =============================================================================

func _get_available_sfx_player() -> AudioStreamPlayer:
	for player in sfx_players:
		if not player.playing:
			return player
	return null

func _get_available_positional_player() -> AudioStreamPlayer2D:
	for player in positional_sfx_players:
		if not player.playing:
			return player
	return null

func _set_music_volume_db(volume_db: float):
	music_player.volume_db = volume_db

func _save_audio_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.save("user://audio_settings.cfg")

func _load_audio_settings():
	var config = ConfigFile.new()
	var error = config.load("user://audio_settings.cfg")
	
	if error == OK:
		master_volume = config.get_value("audio", "master_volume", 1.0)
		music_volume = config.get_value("audio", "music_volume", 0.7)
		sfx_volume = config.get_value("audio", "sfx_volume", 0.8)
	
	# Apply loaded settings
	set_master_volume(master_volume)
	set_music_volume(music_volume)
	set_sfx_volume(sfx_volume)
