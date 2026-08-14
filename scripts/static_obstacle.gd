extends Path2D

@export var max_points := 5
@export var min_max_distance := 10.0
@export var min_max_range := Vector2(0.0, TAU)
#@export_tool_button("Generate path")
#var path = generate_path


func _ready() -> void:
	generate_path()


func generate_path() -> void:
	curve.clear_points()
	for i in max_points:
		var random_vector = Vector2.from_angle(randf_range(min_max_range.x, min_max_range.y))
		random_vector *= min_max_distance
		curve.add_point(random_vector)

	var cnt = curve.get_point_count()
	if cnt:
		curve.set_point_position(cnt - 1, curve.get_point_position(0))
