extends CharacterBody2D


const MAX_SPEED = 200.0
const ACCEL_COEIFIENT = 20
const FRICTION_COIFICIENT = 10
const TURN_SPEED = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# direction initialized to default
var direction = Vector2(0,1)

# initializing speed
var speed = 0

# initialize direction of acceleration
var forward = 0

#initialize
var turn = 0

func _physics_process(delta):
	applyTurning(delta)
	
	var sin = sin(rotation)
	var cos = cos(rotation)
	
	direction = Vector2(direction.x * cos + direction.y * sin, -1 * direction.x * sin + direction.y * cos).normalized()
	
	applyFriction(delta)
	applyAcceleration(delta)

	velocity.x = direction.x * speed 
	velocity.y = direction.y * speed

	move_and_slide()
	
func applyTurning(delta):
	rotate(TURN_SPEED * turn)

func applyFriction(delta):
	if abs(speed) < 0.08:
		speed = 0
	
	if speed > 0:
		speed -= FRICTION_COIFICIENT
	elif speed < 0:
		speed += FRICTION_COIFICIENT

func applyAcceleration(delta):
	speed += forward * ACCEL_COEIFIENT
	
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	elif speed < -1 * MAX_SPEED:
		speed = -1 * MAX_SPEED

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
		
		if event.pressed and (event.keycode == KEY_W or event.keycode == KEY_UP):
			forward = 1
		elif event.pressed and (event.keycode == KEY_S or event.keycode == KEY_DOWN):
			forward = -1
		else:
			forward = 0
		
		if event.pressed and (event.keycode == KEY_A or event.keycode == KEY_LEFT):
			turn = -1
		elif event.pressed and (event.keycode == KEY_D or event.keycode == KEY_RIGHT):
			turn = 1
		else:
			turn = 0
