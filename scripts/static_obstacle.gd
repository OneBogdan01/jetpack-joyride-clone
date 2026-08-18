class_name BeeCurve
extends Path2D

func _ready() -> void:
	set_random_rotation()


func spawn_bees(count: int = 5):
	if get_node_or_null("MovingObstacle") != null:
		$MovingObstacle.add_bees(count)


func set_random_rotation(rotations := [0.0, PI / 4, PI / 2]) -> void:
	rotation = rotations.pick_random()
