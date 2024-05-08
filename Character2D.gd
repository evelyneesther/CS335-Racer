extends CharacterBody2D

const MAX_SPEED = 3000 # pix/sec
const ACCELERATION_COIFICIENT = 4000 # pix/sec^2
const FRICTION_COIFICTIENT = 12000
const TURN_SPEED = 1.5 # rad/sec
const MASS = 1

var energy = 0 # for accurate ish physics
var speed = 0
signal speed_change
# polarity of velocity vector, what turns speed into velocity, stops instant stops on no input
var polarity = 0

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main_menu.tscn")

		

func _physics_process(delta):	
	var move_input = Input.get_axis("back", "forward")
	var rotation_direction = Input.get_axis("left", "right")
	
	# Real physics not implemented right, deal with later
	
	if move_input != 0:
		energy += ACCELERATION_COIFICIENT
		polarity = move_input
		
	if speed > MAX_SPEED:
		energy = ((MAX_SPEED ** 2) * MASS) / 2
	
	speed = sqrt((2 * energy) / MASS)
	emit_signal("speed_change", speed)
	
	velocity = transform.x * polarity * speed
	
	rotation += rotation_direction * TURN_SPEED * delta
	
	if energy > 0 and not move_input:
		energy -= FRICTION_COIFICTIENT
	
	if energy < 0:
		energy = 0
	
	move_and_slide()
