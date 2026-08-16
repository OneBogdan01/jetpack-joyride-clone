extends PathFollow2D

@export var obstacle_count := 5
@export var obstacle: PackedScene


func _ready() -> void:
	await get_parent().ready
	add_bees()


func add_bees():
	for child in get_children():
		child.queue_free()
	for i in obstacle_count:
		var instance = obstacle.instantiate() as Node2D
		progress_ratio = float(i) / (obstacle_count - 1)
		instance.position = position.rotated(get_parent().rotation)
		owner.add_child.call_deferred(instance)
