extends Button


func _physics_process(_delta: float) -> void:
	if is_pressed():
		get_tree().change_scene_to_file("res://Resources/Scenes/laps.tscn")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://Resources/Scenes/laps.tscn")
