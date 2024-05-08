extends CharacterBody2D

const MAX_SPEED = 1000 # pix/sec
const ACCELERATION_COIFICIENT = 40 # pix/sec^2
const FRICTION_COIFICTIENT = 10
const TURN_SPEED = 1.5 # rad/sec
const MASS = 1

var energy = 0 # for accurate physics
var speed = 0

# polarity of velocity vector, what turns speed into velocity, stops instant stops on no input
var polarity = 0

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _physics_process(delta):	
	var move_input = Input.get_axis("back", "forward")
	var rotation_direction = Input.get_axis("left", "right")
	
	# Real physics not implemented right, deal with later
	# energy = ((speed * speed) * MASS) / 2
	# energy += ACCELERATION_COIFICIENT
	# speed = sqrt((2 * energy) / MASS)
	
	if move_input != 0:
		speed += ACCELERATION_COIFICIENT
		polarity = move_input
	
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	
	velocity = transform.x * polarity * speed
	
	rotation += rotation_direction * TURN_SPEED * delta
	
	if speed > 0:
		speed -= FRICTION_COIFICTIENT 
	
	move_and_slide()
