extends Area2D
class_name HitboxComponent

@export var damage :int = 10

func _init() -> void:
	monitorable = false
	monitoring = true
	collision_layer = 0
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(area:Area2D) -> void:
	if area is HurtboxComponent:
		area.hurtbox_entered(damage)
