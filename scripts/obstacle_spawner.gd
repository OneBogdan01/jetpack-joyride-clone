class_name ObstacleSpawner
extends Node2D

@export var node_to_spawn: PackedScene
@onready var timer: Timer = $Timer

signal score_triggered


func start():
	spawn()
	timer.start()


func stop():
	process_mode = Node.PROCESS_MODE_DISABLED


func spawn():
	var instance = node_to_spawn.instantiate() as ObstaclePair
	instance.score_triggered.connect(_score_triggered)
	add_child(instance)


func _score_triggered():
	score_triggered.emit()


func _on_timer_timeout() -> void:
	spawn()
