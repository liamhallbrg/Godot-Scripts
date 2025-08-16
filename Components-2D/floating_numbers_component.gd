extends Node2D
class_name FloatingNumbersComponent

@export var offset : Vector2 = Vector2.ZERO
@onready var floating_number_preload : PackedScene= preload("res://scenes/floating_number.tscn")

func spawn_floating_number(damage_amount : int, damage_type : StaticTypes.DamageType) -> void:
	var floating_number = floating_number_preload.instantiate() as FloatingNumber
	get_tree().current_scene.get_node("FloatingNumbers").add_child(floating_number)
	floating_number.initialize(damage_amount, damage_type, global_position + offset)
