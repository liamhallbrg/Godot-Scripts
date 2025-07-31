extends Area2D
class_name HurtBoxComponent

@export var damage :int = 10

func _init() -> void:
	monitoring = false
	collision_mask = 0
