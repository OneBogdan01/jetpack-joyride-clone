class_name JetpackController
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectiles_particles: GPUParticles2D = $Bullets
@onready var muzzle: Sprite2D = $Muzzle

@export var dead_body: PackedScene
@export var force_on_die := Vector2(30, 1.0)
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
var allow_input = false

signal obstacle_hit

var _time_in_state := 0.0

var moving_down = true:
	set(value):
		moving_down = value
		_time_in_state = 0.0
		projectiles_particles.emitting = !value
		muzzle.visible = !value

const JETPACK_PROJECTILES = preload("uid://brgdcrs3evu7d")


func _ready() -> void:
	projectiles_particles.emitting = true

	projectiles_particles.emitting = false

	muzzle.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if allow_input == false:
		return
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
	if moving_down == false:
		velocity.y += -force_up * accelearation_curve_up.sample(
			_time_in_state / acceleration_time_up,
		)
		increment_time(delta, acceleration_time_up)
	else:
		velocity.y += force_down * accelearation_curve_down.sample(
			_time_in_state / acceleration_time_down,
		)
		increment_time(delta, acceleration_time_down)

	velocity.y = clampf(velocity.y, -top_speed_up, top_speed_down)
	if is_on_floor():
		animation_player.assigned_animation = "walk"
	else:
		animation_player.assigned_animation = "fly"

	move_and_slide()


func hit_obstacle(from: Vector2 = Vector2.ZERO):
	queue_free()
	_dead = true
	obstacle_hit.emit()
	var inst = dead_body.instantiate() as RigidBody2D
	inst.position = position
	inst.apply_impulse(
		Vector2(%ObstacleSpawner.obstacle_speed * force_on_die.x, force_on_die.y),
		from - global_position,
	)
	get_parent().add_child.call_deferred(inst)
