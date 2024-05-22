extends Control


func _ready():
	get_tree().paused = true


func _on_retry_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file('res://Resources/Scenes/overhead.tscn')


func _on_main_menu_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file('res://Resources/Scenes/main_menu.tscn')
