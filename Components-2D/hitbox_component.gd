extends Area2D
class_name HitboxComponent

@export var damage :int = 10
@export var knockback : int = 500
@export var damage_type : StaticTypes.DamageType = StaticTypes.DamageType.NORMAL

func _init() -> void:
	monitorable = false
	monitoring = true
	collision_layer = 0
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(area:Area2D) -> void:
	if area is HurtboxComponent:
		area.hit(HitInfo.new(damage, damage_type, Vector2.ZERO, knockback))
