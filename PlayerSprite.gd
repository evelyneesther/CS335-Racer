extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture=load(CarArt.selected_car())
	pass # Replace with function body.

