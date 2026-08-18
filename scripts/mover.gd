class_name Mover
extends Node2D

enum SpawnPoint {
	RANDOM,
	PLAYER,
}

@export var direction: Vector2 = Vector2.LEFT
@export var speed = 100.0
@onready var static_obstacle: BeeCurve = %StaticObstacle

@export var point: SpawnPoint


func set_spawn_point(curve_pos: Vector2, player_y: Vector2):
	if point == SpawnPoint.RANDOM:
		position = curve_pos
	else:
		position = Vector2(curve_pos.x, player_y.y)


func _physics_process(delta: float) -> void:
	position += direction * delta * speed
