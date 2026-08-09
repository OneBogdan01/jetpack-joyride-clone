extends Node

const SCENE_PATH: String = "res://scenes/main.tscn"


func restart_game():
	get_tree().paused = false
	get_tree().change_scene_to_file(SCENE_PATH)
