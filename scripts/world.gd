class_name World
extends Node2D

@onready var player: Player = $Player

@onready var backgrounds: Node2D = $Backgrounds


func stop_movement():
	backgrounds.process_mode = Node.PROCESS_MODE_DISABLED
