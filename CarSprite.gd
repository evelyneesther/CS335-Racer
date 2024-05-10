extends Sprite2D

var front
var color
var back
var sides
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	color="Red"
	front=""
	back=""
	sides=""
	direction=""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func selected_car():
	var carstr="res://Art/"+color+"/"+color+" - "+front+back+sides+direction
	carstr=carstr.strip_edges()
	
	CarArt.car=carstr+".png"
	print(CarArt.selected_car())
	return(carstr+".png")

func _on_front_wing_button_item_selected(index):
	if index==0:
		front=""
	elif index==1:
		front="FrontWing "
	self.texture=load(selected_car())


func _on_dorsal_wing_button_item_selected(index):
	if index==0:
		sides=""
	elif index==1:
		sides="SideWing"
	var newcar=selected_car()
	self.texture=load(selected_car())
	
	pass # Replace with function body.
