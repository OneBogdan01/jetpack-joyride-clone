extends Node2D

func _on_timer_timeout() -> void:
	var body := get_parent()
	var target: float = body.speed * 4.0

	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(body, "speed", target, 0.6) \
			.set_trans(Tween.TRANS_EXPO) \
			.set_ease(Tween.EASE_IN)
