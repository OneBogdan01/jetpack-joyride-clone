class_name Score
extends Label

var current_score := 0:
	set(value):
		current_score = value
		text = str(current_score)


func _ready() -> void:
	current_score = 0


func increment():
	current_score += 1
