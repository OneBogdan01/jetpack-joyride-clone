extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit_obstacle"):
		body.hit_obstacle(global_position)
