extends Node

@export var obstacle_spawner: ObstacleSpawner
@onready var game_over_menu: GameOver = %GameOverMenu

@onready var score: Score = %Score
@onready var world: World = %World

var _highscore := -1


func _ready() -> void:
	obstacle_spawner.score_triggered.connect(score.increment)


func save_new_highscore():
	_highscore = score.current_score
	SaveManager.save_key_value("high_score", str(_highscore))


func determine_high_score():
	var loaded_score = SaveManager.load_key_value("high_score")
	if loaded_score == null:
		save_new_highscore()
	elif int(loaded_score) < score.current_score:
		save_new_highscore()
	else:
		_highscore = int(loaded_score)


func _on_player_hit_enviroment() -> void:
	print("Game Over!")
	obstacle_spawner.stop()
	world.stop_movement()
	game_over_menu.show()
	game_over_menu.score_number.text = str(score.current_score)
	determine_high_score()
	game_over_menu.high_score_number.text = str(_highscore)


func _on_intro_screen_started_game() -> void:
	score.show()
	obstacle_spawner.start()
	world.player.freeze = false
