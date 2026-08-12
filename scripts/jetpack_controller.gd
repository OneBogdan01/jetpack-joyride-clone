class_name JetpackController
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_category("Force Up")
@export var force_up: float
@export var top_speed_up: float

@export var accelearation_curve_up: Curve
@export var acceleration_time_up: float = 1.0
@export_category("Force Down")
@export var force_down: float
@export var top_speed_down: float
@export var accelearation_curve_down: Curve
@export var acceleration_time_down: float = 1.0

var _dead := false

signal hit_obstacle

var _time_in_state: = 0.0

var moving_down = true:
	set(value):
		moving_down = value
		_time_in_state = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("movement_action"):
		moving_down = false

	if event.is_action_released("movement_action"):
		moving_down = true

		#velocity *= 0.5


func increment_time(increment: float, max_limit: float):
	_time_in_state = clampf(_time_in_state + increment, 0.0, max_limit)


func _physics_process(delta: float) -> void:
	if _dead:
		return
	if Input.is_action_pressed("movement_action"):
		velocity.y += -force_up * accelearation_curve_up.sample(_time_in_state / acceleration_time_up)
		increment_time(delta, acceleration_time_up)

	else:
		velocity.y += force_down * accelearation_curve_down.sample(_time_in_state / acceleration_time_down)
		increment_time(delta, acceleration_time_down)

	velocity.y = clampf(velocity.y, -top_speed_up, top_speed_down)
	if is_on_floor():
		animation_player.assigned_animation = "walk"
	else:
		animation_player.assigned_animation = "fly"

	move_and_slide()


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("floor"):
		animation_player.assigned_animation = "fly"
	elif body.is_in_group("obstacles"):
		_dead = true
		hit_obstacle.emit()
		print("Player hit an obstacle" + body.name)
