class_name ObstaclePair
extends Area2D
@onready var bottom: StaticBody2D = $Bottom
@onready var top: StaticBody2D = $Top
@export var middle_size = 1.9

@export var min_size := 0.5
@export var max_size := 3.2

signal score_triggered


func set_size_obstacles():
	bottom.scale.y = middle_size
	top.scale.y = -middle_size


func set_random_obstacle_size():
	var random_size = randf_range(min_size, max_size)
	var diff = middle_size - random_size
	bottom.scale.y = random_size
	top.scale.y = -middle_size - diff


func _ready() -> void:
	set_random_obstacle_size()


func _on_body_exited(body: Node2D) -> void:
	score_triggered.emit()
	print("Player collected 1 point.")
