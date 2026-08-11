class_name JetpackController
extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var force: Vector2

var _dead := false

signal hit_obstacle
var _initial_gravity_scale = gravity_scale


func _physics_process(delta: float) -> void:
	if _dead:
		return
	if Input.is_action_pressed("movement_action"):
		gravity_scale = 0.0
		print(linear_velocity)
		apply_central_force(-force)
	else:
		gravity_scale = _initial_gravity_scale


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("floor"):
		animation_player.assigned_animation = "walk"


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("floor"):
		animation_player.assigned_animation = "fly"
	elif body.is_in_group("obstacles"):
		_dead = true
		hit_obstacle.emit()
		print("Player hit an obstacle" + body.name)
