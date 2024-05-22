extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const ROTATE_SPEED = .02

var mousePosition = Vector2(0, 0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	mousePosition = Vector2(get_window().size.x / 2, get_window().size.x / 2)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		mousePosition = event.position

func _physics_process(delta):
	if mousePosition.x > (get_window().size.x + 120) / 2:
		rotate_y(-ROTATE_SPEED)
	elif mousePosition.x < (get_window().size.x - 120) / 2:
		rotate_y(ROTATE_SPEED) 
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
