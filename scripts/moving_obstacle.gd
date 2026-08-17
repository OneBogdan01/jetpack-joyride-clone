extends PathFollow2D

@export var obstacle: PackedScene


func add_bees(obstacle_count: int):
	for i in obstacle_count:
		var instance = obstacle.instantiate() as Node2D
		progress_ratio = float(i) / (obstacle_count - 1)
		instance.position = get_parent().transform * position
		get_parent().get_parent().add_child.call_deferred(instance)
