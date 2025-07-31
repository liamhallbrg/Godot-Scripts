extends Node
class_name HealthComponent

@export var max_health : int = 100

var health : int = max_health
var alive : bool = true

signal Died
signal HealthMaxed

func damage(amount :int = 0) -> void:
	if !alive:  print(owner.name + " is already dead!")
	health -= amount
	_control_health()


func heal(amount :int = 0) -> void:
	if !alive: print(owner.name + " is already dead!")
	health += amount
	_control_health()


func kill() -> void:
	Died.emit()
	health = 0
	alive = false


func _control_health() ->void:
	if health < 0:
		kill()
	elif health > max_health:
		health = max_health
		HealthMaxed.emit()
