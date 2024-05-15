extends CharacterBody2D

# TODO: improve polarity system such that changing directions is good

const MAX_SPEED = 3000 # pix/sec
const ACCELERATION_COIFICIENT = 6000 # pix/sec^2
const FRICTION_COIFICTIENT = 20000
const TURN_SPEED = 2.2 # rad/sec
const MASS = 1.2
const DRIFT_MODIFIER = 0.5

var energy = 0 # for accurate ish physics
var speed = 0

# polarity of velocity vector, what turns speed into velocity, stops instant stops on no input
var polarity = 0

var brake = 0

signal speed_change

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main_menu.tscn")
		elif event.is_action_pressed("reset"):
			get_tree().change_scene_to_file("res://overhead.tscn")

func _physics_process(delta):	
	var move_input = Input.get_axis("back", "forward")
	var rotation_direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("brake"):
		brake = 1
	elif Input.is_action_just_released("brake"):
		brake = 0
	
	move_input=hitWall(move_input)
	applyAcceleration(move_input)

	velocity = transform.x * polarity * speed
	
	rotation += rotation_direction * (TURN_SPEED + DRIFT_MODIFIER * brake) * delta
	
	applyFriction(move_input)
	
	move_and_slide()

func applyAcceleration(move_input):
	if energy == 0:
		polarity = move_input
	
	if polarity > 0:
		energy += move_input * (ACCELERATION_COIFICIENT - brake * 3000)
	elif polarity < 0:
		energy += -1 * move_input * (ACCELERATION_COIFICIENT + brake * 3000)
	
	if energy < 0:
		energy = 0
	
	if speed > (MAX_SPEED - brake * 1000):
		energy = (((MAX_SPEED - brake * 1000) ** 2) * MASS) / 2
	
	speed = sqrt((2 * energy) / MASS)
	
	emit_signal("speed_change", speed)
	

func applyFriction(move_input):
	if move_input != polarity or polarity == 0:
		if speed < 10:
			energy -= FRICTION_COIFICTIENT / 1024
		elif speed < 20:
			energy -= FRICTION_COIFICTIENT / 246
		elif speed < 40:
			energy -= FRICTION_COIFICTIENT / 32
		elif speed < 80:
			energy -= FRICTION_COIFICTIENT / 16
		elif speed < 160:
			energy -= FRICTION_COIFICTIENT / 2
		else:
			energy -= FRICTION_COIFICTIENT
	
	if energy < 0:
		energy = 0
		
func hitWall(moveInput):
	for i in get_slide_collision_count():
		energy*=.85
		if energy<6000:
			energy=0
			return(0)
		
	return(moveInput)

func printOutputs():
	print("Speed: ")
	print(speed)
	print("Energy: ")
	print(energy)
	print()


