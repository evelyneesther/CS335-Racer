extends Button
	
func _physics_process(_delta: float) -> void:
	if is_pressed():
		get_tree().change_scene_to_file("res://Resources/Scenes/laps.tscn")
