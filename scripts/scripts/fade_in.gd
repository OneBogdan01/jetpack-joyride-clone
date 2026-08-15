extends CanvasItem

@export var time_to_fade := 1.0
@export var easy_type: Tween.EaseType
@export var start_color := Color.TRANSPARENT
@export var final_color := Color.WHITE

signal finished


func fade_in() -> void:
	var fade = create_tween()
	fade.set_ease(easy_type)
	modulate = start_color
	fade.tween_property(self, "modulate", final_color, time_to_fade)
	await fade.finished
	finished.emit()


func _on_visibility_changed() -> void:
	if visible == true:
		fade_in()
