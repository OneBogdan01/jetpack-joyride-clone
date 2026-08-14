class_name World
extends Node2D

@onready var player: JetpackController = %Player

@onready var backgrounds: Node2D = $Backgrounds
@onready var ground: Parallax2D = %Ground
@onready var far_away: Parallax2D = %FarAway


func stop_movement():
	backgrounds.process_mode = Node.PROCESS_MODE_DISABLED


func update_ground_speed(new_speed: float):
	ground.autoscroll.x = -new_speed
	far_away.autoscroll.x = -new_speed / 2.0
