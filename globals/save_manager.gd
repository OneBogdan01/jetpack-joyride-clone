extends Node

const CONFIG_PATH := "user://scores.cfg"
const SECTION_NAME := "DefaultSection"
var config = ConfigFile.new()
var score_data = { }


func _ready() -> void:
	var err = config.load(CONFIG_PATH)

	# If the file didn't load, ignore it.
	if err != OK:
		print("No config file found")
		return


func load_key_value(key: String):
	return config.get_value(SECTION_NAME, key)


func save_key_value(key: String, value: String) -> void:
	config.set_value(SECTION_NAME, key, value)
	config.save(CONFIG_PATH)
