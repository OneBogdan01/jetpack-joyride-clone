extends Node2D

var speed = randf_range(1.0, 5.0)


func _physics_process(delta: float) -> void:
	rotation += delta * speed
