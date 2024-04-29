extends CharacterBody3D


const MAX_SPEED = 5.0
const ACCEL_COIFFICIENT = 0.1
const FRICTION_COEIFFIENT = 0.05
const TURN_SPEED = 0.05

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# a bool to define if we need to accelerate
var forward = 0
var turn = 0

# current speed
var speed = 0

#initializing direction vector
var direction2d = Vector2(-1,0)

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

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
	
	applyTurning(delta)
	
	var direction = (transform.basis * Vector3(direction2d.x, 0, -direction2d.y)).normalized()
	
	applyAccelerationToSpeed(delta)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	applyFriction(delta)
	
	# Print Outputs
	printOutputs(direction, velocity)

	move_and_slide()
	

func applyTurning(delta):
	rotate_object_local(Vector3(0, 1, 0), (turn * TURN_SPEED))
	
	if turn != 0:
		var angle = get_global_rotation().y
	
		var cos = cos(angle)
		var sin = sin(angle)
		direction2d = Vector2(direction2d.x * cos + -1 * direction2d.y * sin, direction2d.x * sin + direction2d.y * cos)

func applyFriction(delta):
	if speed > 0:
		speed -= FRICTION_COEIFFIENT
	elif speed < 0:
		speed += FRICTION_COEIFFIENT
	
	if abs(speed) < 0.05:
		speed = 0

func applyAccelerationToSpeed(delta):
	speed += forward * ACCEL_COIFFICIENT
	
	if speed >= MAX_SPEED:
		speed = MAX_SPEED
	elif speed <= -1 * MAX_SPEED:
		speed = -1 * MAX_SPEED

func printOutputs(direction, velocity):
	print(turn)
	print("speed: ")
	print(speed)
	print("direction: ")
	print(direction)
	print("velocity: ")
	print(velocity)
	print("Rotation: ")
	print(get_global_rotation())
	print()
