extends Node2D


# this script can also be used for future new levels :D

#@onready var finish_line_pos = $FinishLine.global_position

var first_lap_finished = false
var laps_completed = 1
var race_finished = false
var has_looped=false


func _ready():
	ManagerGame.global_level_ref = self
	ManagerGame.startTime=Time.get_unix_time_from_system()
	ManagerGame.fastestLap=99999999
	ManagerGame.readScores()
	get_tree().paused = false


func _on_new_lap_detector_body_entered(body):
	if has_looped==false:
		return
	has_looped=false
	
	ManagerGame.endTime=Time.get_unix_time_from_system()
	var lapTime=snapped(ManagerGame.endTime-ManagerGame.startTime,.001)
	if lapTime<ManagerGame.fastestLap:
		ManagerGame.fastestLap=lapTime
	ManagerGame.startTime=ManagerGame.endTime
	if first_lap_finished:
		laps_completed += 1
	else:
		first_lap_finished = true
		laps_completed+=1
	
	# check laps if max
	if laps_completed > ManagerGame.laps_max and race_finished == false:
		#ManagerGame.newScore(ManagerGame.fastestLap, "TMP")
		laps_completed-=1
		ManagerGame.race_finished.emit()
		print(ManagerGame.fastestLap)
		race_finished = true
		%Vehicle.canMove=false


func _on_loop_detector_player_detected():
	has_looped=true


func _on_vehicle_show_pit_stop():
	%PitStopMenu.visible=true


func _on_hell_portal_input_event(viewport, event, shape_idx):
	get_tree().change_scene_to_file("res://Resources/Scenes/pseudo_3d.tscn")
	pass # Replace with function body.
