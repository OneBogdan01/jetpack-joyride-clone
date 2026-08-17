class_name ObstacleSpawner
extends Node2D

@export var node_to_spawn: Array[PackedScene]
@export var obstacle_speed := 100.0:
	set(value):
		obstacle_speed = value
		obstacle_speed_changed.emit(value)

@onready var timer: Timer = $Timer
@onready var score_update: Timer = $ScoreUpdate
@onready var difficulty_increase: Timer = $DifficultyIncrease

@onready var sample_spawn: PathFollow2D = %SampleSpawn

var distance_travelled := 0.0

signal score_triggered(distance: float)
signal obstacle_speed_changed(new_speed: float)


func start():
	obstacle_speed_changed.emit(obstacle_speed)
	timer.start()
	score_update.start()
	difficulty_increase.start()


func stop():
	timer.stop()
	score_update.stop()


func spawn():
	var instance = node_to_spawn.pick_random().instantiate() as Mover
	instance.speed = obstacle_speed

	sample_spawn.progress_ratio += randf()
	sample_spawn.force_update_transform()
	instance.position = sample_spawn.position
	print(instance.position)

	add_child(instance)

	var scale_value = 1.0 + clamp(log(distance_travelled - 100) * randf_range(0.2, 1.0), 0.0, 2.0)
	instance.static_obstacle.scale = Vector2(scale_value, scale_value)
	await get_tree().process_frame
	instance.static_obstacle.spawn_bees(randi_range(5, 10))


func _on_timer_timeout() -> void:
	spawn()


func _physics_process(delta: float) -> void:
	distance_travelled += delta * obstacle_speed


func _on_score_update_timeout() -> void:
	score_triggered.emit(distance_travelled)


func _on_difficulty_increase_timeout() -> void:
	obstacle_speed += log(distance_travelled)
