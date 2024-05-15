extends Node

var carPath
var carCode
# Called when the node enters the scene tree for the first time.
func _ready():
	carPath="res://Art/Red/Red -.png"
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("fullscreen"):
			var test=DisplayServer.window_get_mode()
			if test==0:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			elif test==3:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
			print(test)
	
func selected_car():
	
	print(carCode)
	return(carPath)
