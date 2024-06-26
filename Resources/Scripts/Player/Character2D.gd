extends CharacterBody2D

# TODO: improve polarity system such that changing directions is good
signal show_pit_stop

var maxSpeed = 3000 # pix/sec
var accelerationCoifictient = 6000 # pix/sec^2
const FRICTION_COIFICTIENT = 20000
var turnSpeed = 2.2 # rad/sec
var mass = 1.2
var driftModifier = 0.5

var energy = 0 # for accurate ish physics
var speed = 0

# polarity of velocity vector, what turns speed into velocity, stops instant stops on no input
var polarity = 0

var brake = 0

var canMove=true

var grassMult=false

var inPitStop=false

var canShowPitStop=true

signal speed_change

func _ready():
	grassMult=false
	gen_car()
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://Resources/Scenes/main_menu.tscn")
		elif event.is_action_pressed("reset"):
			get_tree().change_scene_to_file(ManagerGame.currMap)

func _physics_process(delta):	
	var move_input = Input.get_axis("back", "forward")
	var rotation_direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("brake"):
		brake = 1
	elif Input.is_action_just_released("brake"):
		brake = 0
	
	move_input=hitWall(move_input)
	
	if canMove==false:
		return
		
	applyAcceleration(move_input)

	velocity = transform.x * polarity * speed
	
	rotation += rotation_direction * (turnSpeed + driftModifier * brake) * delta
	
	applyFriction(move_input)
	
	move_and_slide()

func applyAcceleration(move_input):
	if inPitStop&&speed==0&&canShowPitStop:
		emit_signal("show_pit_stop")
		canMove=false
		canShowPitStop=false
	if energy == 0:
		polarity = move_input
	
	if polarity > 0:
		energy += move_input * (accelerationCoifictient - brake * 3000)
	elif polarity < 0:
		energy += -1 * move_input * (accelerationCoifictient + brake * 3000)
	
	if energy < 0:
		energy = 0
	
	if speed > (maxSpeed - brake * 1000):
		energy = (((maxSpeed - brake * 1000) ** 2) * mass) / 2
	
	speed = sqrt((2 * energy) / mass)
	if grassMult==true:
		speed*=.8
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



func _on_grass_body_entered(body):
	if body==self:
		grassMult=true
	pass # Replace with function body.


func _on_grass_body_exited(body):
	if body==self:
		grassMult=false
	pass # Replace with function body.

func gen_car():
	var carCode=CarArt.carCode
	mass=1.2
	match carCode[0]:
		"R":
			maxSpeed=3000
		"O":
			maxSpeed=2500
		"B":
			maxSpeed=1500
		"G":
			maxSpeed=2000
		"P":
			maxSpeed=5000
	match carCode[1]:
		"D":
			mass=1.2
			turnSpeed=2.2
		"W":
			mass+=.15
			turnSpeed+=.5
	match carCode[2]:
		"D":
			accelerationCoifictient=6000
		"W":
			mass+=.15
			accelerationCoifictient=10000
	match carCode[3]:
		"D":
			driftModifier=.5
		"W":
			mass+=.15
			driftModifier=.85
	$PlayerSprite.reloadTexture()


func _on_entered_pit_stop_body_entered(body):
	if body==self:
		inPitStop=true


func _on_entered_pit_stop_body_exited(body):
	if body==self:
		inPitStop=false


func _on_loop_detector_player_detected():
	canShowPitStop=true


func _on_hell_portal_body_entered(body):
	if body==self:
		get_tree().change_scene_to_file("res://Resources/Scenes/pseudo_3d.tscn")
