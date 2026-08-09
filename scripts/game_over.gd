class_name GameOver
extends Control

@onready var play_button: Button = %Play
@onready var quit_button: Button = %Quit
@onready var score_number: Label = %ScoreNumber
@onready var high_score_number: Label = %HighScoreNumber


func _ready() -> void:
	play_button.pressed.connect(LevelManager.restart_game)
	quit_button.pressed.connect(quit)
	if OS.get_name() == "Web":
		quit_button.hide()


func quit():
	get_tree().quit()
