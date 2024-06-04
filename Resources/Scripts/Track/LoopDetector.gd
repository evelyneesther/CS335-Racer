extends Area2D

signal player_detected
# Called when the node enters the scene tree for the first time.

func _on_input_event(viewport, event, shape_idx):
	emit_signal("player_detected")
	
func emit():
	emit_signal("player_detected")


func _on_body_entered(body):
	if body==%Vehicle:
		emit()
	pass # Replace with function body.
