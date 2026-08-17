class_name Mover
extends Node2D

@export var direction: Vector2 = Vector2.LEFT
@export var speed = 100.0
@onready var static_obstacle: BeeCurve = %StaticObstacle


func _physics_process(delta: float) -> void:
	position += direction * delta * speed
