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


func set_spawn_point(curve: PathFollow2D):
	curve.progress_ratio = randf()
	curve.force_update_transform()
	if point == SpawnPoint.RANDOM:
		global_position = curve.global_position
	else:
		var player := get_tree().get_first_node_in_group("player") as Node2D
		global_position = Vector2(curve.global_position.x, player.global_position.y)


func _physics_process(delta: float) -> void:
	position += direction * delta * speed
