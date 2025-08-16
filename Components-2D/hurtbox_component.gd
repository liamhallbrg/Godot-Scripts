extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var spawn_floating_number : bool = true

signal Hit

func _init() -> void:
	monitorable = true
	monitoring = false
	collision_mask = 0

func _ready() -> void:
	if (!health_component):
		printerr("Missing HealthComponent on " + str(get_path()) + "'s HurtboxComponent")


func hit(hit_info:HitInfo) -> void:
	Hit.emit(hit_info)
	health_component.damage(hit_info.damage_amount)
