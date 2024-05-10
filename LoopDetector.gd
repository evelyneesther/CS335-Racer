extends Area2D

signal player_detected
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body)
	emit_signal("area_entered")
	pass # Replace with function body.
	
func _on_area_entered(area):
	print(area)
	





func _on_input_event(viewport, event, shape_idx):
	emit_signal("player_detected")
	pass # Replace with function body.
