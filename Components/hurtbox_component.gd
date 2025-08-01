extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent

signal Hit

func _init() -> void:
	monitorable = true
	monitoring = false
	collision_mask = 0

func _ready() -> void:
	if (!health_component):
		printerr("Missing HealthComponent on " + str(get_path()) + "'s HurtboxComponent")


func hurtbox_entered(amount: int) -> void:
	if !health_component: return
	
	Hit.emit(amount)
	health_component.damage(amount)
