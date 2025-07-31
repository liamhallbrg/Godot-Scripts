extends Area2D
class_name HitBoxComponent

@export var health_component : HealthComponent

signal Hit

func _init() -> void:
	monitorable = false
	collision_layer = 0
	connect("area_entered", hurtbox_entered)

func _ready() -> void:
	if (!health_component):
		printerr("Missing HealthComponent on " + str(get_path()) + "'s HitBoxComponent")


func hurtbox_entered(area : Area2D) -> void:
	if !area is HurtBoxComponent: return
	if !health_component: return
	
	Hit.emit(area)
	health_component.damage(area.damage)
