class_name BeeCurve
extends Path2D

@onready var moving_obstacle: PathFollow2D = $MovingObstacle


func _ready() -> void:
	set_random_rotation()


func spawn_bees(count: int = 5):
	moving_obstacle.add_bees(count)


func set_random_rotation(rotations := [0.0, PI / 4, PI / 2]) -> void:
	rotation = rotations.pick_random()
