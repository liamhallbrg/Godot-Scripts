extends Node
var noise : FastNoiseLite = preload("res://settings/camera_shake_noise.tres")

var shake_strength :float = 0.0
var shake_speed :float = 30.0
var noise_index :float= 0.0
var decay_rate :float = 8.0


func add_trauma(amount: float) -> void:
	shake_strength += amount


func set_frequency(freq: float) -> void:
	noise.frequency = freq


func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	noise_index += delta * shake_speed


func get_offset() -> Vector2:
	return Vector2(
		noise.get_noise_2d(1, noise_index) * shake_strength,
		noise.get_noise_2d(100, noise_index) * shake_strength
	)
