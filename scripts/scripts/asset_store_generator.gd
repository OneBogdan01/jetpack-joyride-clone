@tool
extends Control

@export_tool_button("Take all screenshots")
var screenshots = take_all_screenshots
@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer


func take_all_screenshots():
	sub_viewport_container.show()
	sub_viewport_container.hide()
