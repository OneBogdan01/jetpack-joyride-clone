extends Control

signal started_game
@onready var highscore: Label = %Highscore

@onready var world: World = %World
@export var offset_position: Vector2
@export var duration: float = 1.0


func _ready() -> void:
	highscore.text = "0"
	var value = SaveManager.load_key_value("high_score")
	if value:
		highscore.text = str(value)
	# start lower
	world.player.global_position -= offset_position
	var player_tween = create_tween()
	player_tween.set_trans(Tween.TRANS_SINE)
	player_tween.set_loops()
	player_tween.tween_property(world.player, "global_position", world.player.global_position + offset_position, duration)
	player_tween.tween_property(world.player, "global_position", world.player.global_position - offset_position, duration)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tap"):
		started_game.emit()
		queue_free()
