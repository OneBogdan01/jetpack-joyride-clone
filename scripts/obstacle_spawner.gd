class_name ObstacleSpawner
extends Node2D

@export var node_to_spawn: PackedScene
@export var obstacle_speed := 100.0:
	set(value):
		obstacle_speed = value
		obstacle_speed_changed.emit(value)

@onready var timer: Timer = $Timer
@onready var score_update: Timer = $ScoreUpdate
@onready var sample_spawn: PathFollow2D = %SampleSpawn

var distance_travelled := 0.0

signal score_triggered(distance: float)
signal obstacle_speed_changed(new_speed: float)


func start():
	obstacle_speed_changed.emit(obstacle_speed)
	spawn()
	timer.start()
	score_update.start()


func stop():
	process_mode = Node.PROCESS_MODE_DISABLED


func spawn():
	var instance = node_to_spawn.instantiate() as Mover
	instance.speed = obstacle_speed
	sample_spawn.progress_ratio = randf()
	add_child(instance)
	instance.global_position = sample_spawn.global_position


func _on_timer_timeout() -> void:
	spawn()


func _physics_process(delta: float) -> void:
	distance_travelled += delta * obstacle_speed


func _on_score_update_timeout() -> void:
	score_triggered.emit(distance_travelled)
