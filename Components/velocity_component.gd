extends Node

class_name VelocityComponent

@export var acceleration : float = 1.0
@export var max_speed : float = 50.0

var velocity : Vector2 = Vector2.ZERO


func move_character(character_body : CharacterBody2D) -> void:
	velocity = velocity.limit_length(max_speed)
	character_body.velocity = velocity
	character_body.move_and_slide()
	
	if (character_body.velocity.x == 0):
		velocity.x = 0
	if (character_body.velocity.y == 0):
		velocity.y = 0


func move_body(rigidbody : RigidBody2D) -> void:
	velocity = velocity.limit_length(max_speed)
	rigidbody.linear_velocity = velocity
	
	if (rigidbody.linear_velocity.x == 0):
		velocity.x = 0
	if (rigidbody.linear_velocity.y == 0):
		velocity.y = 0

# Slows down the velocity by the specified rate.
func slowdown(rate : float = 1.0) -> Vector2:
	accel_velocity(Vector2.ZERO, rate)
	return velocity

# Sets the velocity to (0, 0).
func stop() -> void:
	set_velocity(Vector2.ZERO)

# Changes the max speed.
func set_max_speed(new_max_speed : float) -> float:
	max_speed = new_max_speed
	return max_speed

# Sets the velocity to it's max speed in the specified direction.
func max_velocity(direction : Vector2) -> void:
	accel_velocity(max_speed * direction)

# Accelerates to the velocity over time, instead of instantly adding it.
func accel_velocity(new_velocity : Vector2, accel_multiplier : float = 1.0) -> Vector2:
	var delta := get_process_delta_time()
	new_velocity = velocity.lerp(new_velocity, delta * acceleration * accel_multiplier)
	velocity = new_velocity
	return velocity

## Instantly adds the velocity, instead of over time.
func set_velocity(new_velocity : Vector2) -> void:
	velocity = new_velocity

## Instantly adds the velocity, instead of over time.
func add_velocity(added_velocity : Vector2) -> Vector2:
	return accel_velocity(velocity + added_velocity)
