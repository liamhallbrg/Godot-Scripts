extends Node
class_name KnockbackComponent

@export var velocity_component : VelocityComponent
@export var knockback_enabled : bool = true


func _ready() -> void:
	if (!velocity_component):
		printerr("Missing VelocityComponent on " + str(get_path()) + "'s KnockbackComponent")


func apply_knockback(amount:float, direction : Vector2 = Vector2.RIGHT) -> void:
	if !knockback_enabled: return
	velocity_component.add_velocity(direction*amount)
