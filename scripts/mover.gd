extends StaticBody2D

@export var direction: Vector2 = Vector2.LEFT
@export var speed = 100.0


func _physics_process(delta: float) -> void:
	position += direction * delta * speed
