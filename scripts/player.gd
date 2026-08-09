class_name Player
extends RigidBody2D

signal hit_enviroment
signal tapped

@export var force_on_tap := 400.0

@export var desired_rotation_tap_deg := -65.0
@export var desired_rotation_falling := 70.0
@export var rotation_speed := 50.0
@export var dive_rotation_speed := 1.0

var _dead := false


func _physics_process(delta: float) -> void:
	if _dead:
		return
	if Input.is_action_just_pressed("tap"):
		linear_velocity.y = -force_on_tap
		var torque = angle_difference(rotation, deg_to_rad(desired_rotation_tap_deg))
		angular_velocity = torque * rotation_speed
		tapped.emit()
	else:
		var torque = angle_difference(rotation, deg_to_rad(desired_rotation_falling))
		angular_velocity = torque * dive_rotation_speed


func _on_body_entered(body: Node) -> void:
	_dead = true
	hit_enviroment.emit()
	print("Player hit something" + body.name)
