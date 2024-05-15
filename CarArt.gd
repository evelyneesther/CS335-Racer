extends Node

var carPath
var carCode
# Called when the node enters the scene tree for the first time.
func _ready():
	carPath="res://Art/Red/Red -.png"
	pass # Replace with function body.

	
func selected_car():
	
	print(carCode)
	return(carPath)
