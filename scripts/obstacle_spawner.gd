class_name ObstacleSpawner
extends Node2D

@export var node_to_spawn: Array[PackedScene]

@export_category("Speed Ramp")
@export var start_speed := 100.0
@export var max_speed := 520.0
## Distance travelled at which max_speed is reached.
@export var distance_to_max_speed := 12000.0

@export_category("Spawn Interval")
## Random interval range at the start of the run.
@export var start_interval := Vector2(1.5, 3.0)
## Random interval range once distance_to_min_interval is reached.
@export var min_interval := Vector2(0.7, 1.2)
@export var distance_to_min_interval := 9000.0

@export_category("Obstacle Scale")
@export var scale_ramp_offset := 100.0
@export var max_extra_scale := 2.0

@onready var timer: Timer = $Timer
@onready var score_update: Timer = $ScoreUpdate
@onready var difficulty_increase: Timer = $DifficultyIncrease
@onready var sample_spawn: PathFollow2D = %SampleSpawn

var obstacle_speed := 100.0:
	set(value):
		obstacle_speed = value
		obstacle_speed_changed.emit(value)

var distance_travelled := 0.0
var _running := false

signal score_triggered(distance: float)
signal obstacle_speed_changed(new_speed: float)


func start() -> void:
	distance_travelled = 0.0
	obstacle_speed = start_speed # setter emits, no manual emit needed
	_running = true
	timer.wait_time = randf_range(start_interval.x, start_interval.y)
	timer.start()
	score_update.start()
	difficulty_increase.start()


func stop() -> void:
	_running = false
	timer.stop()
	score_update.stop()
	difficulty_increase.stop()


func _physics_process(delta: float) -> void:
	if not _running:
		return
	distance_travelled += delta * obstacle_speed


## 0.0 at the start of the run, 1.0 once fully ramped.
func _difficulty_ratio(distance_to_max: float) -> float:
	if distance_to_max <= 0.0:
		return 1.0
	return clampf(distance_travelled / distance_to_max, 0.0, 1.0)


func _next_interval() -> float:
	var t := _difficulty_ratio(distance_to_min_interval)
	var lo := lerpf(start_interval.x, min_interval.x, t)
	var hi := lerpf(start_interval.y, min_interval.y, t)
	return randf_range(lo, hi)


func _obstacle_scale() -> float:
	# maxf guards log() against zero and negatives early in the run.
	var d := maxf(distance_travelled - scale_ramp_offset, 1.0)
	var extra := clampf(log(d) * randf_range(0.2, 1.0), 0.0, max_extra_scale)
	return 1.0 + extra


func spawn() -> void:
	timer.wait_time = _next_interval()

	var instance := node_to_spawn.pick_random().instantiate() as Mover
	instance.speed = obstacle_speed
	add_child(instance)

	instance.set_spawn_point(sample_spawn)

	var s := _obstacle_scale()
	instance.static_obstacle.scale = Vector2(s, s)

	await get_tree().process_frame
	if not is_instance_valid(instance):
		return
	instance.static_obstacle.spawn_bees(randi_range(4, 10))


func _on_timer_timeout() -> void:
	spawn()


func _on_score_update_timeout() -> void:
	score_triggered.emit(distance_travelled)


func _on_difficulty_increase_timeout() -> void:
	obstacle_speed = lerpf(start_speed, max_speed, _difficulty_ratio(distance_to_max_speed))
