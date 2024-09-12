extends CharacterBody3D

# how fast the player moves
@export var speed = 14
# the downward acceleration when in the air
@export var fall_acceleration = 75
@export var jump_acceleration = 20
var mouse_sensitivity = 0.002

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	
	#movement
	var input = Input.get_vector("Left","Right","Forwards","Backwards")
	var direction = transform.basis * Vector3(input.x,0.0,input.y)
	
	if is_on_floor() and Input.is_action_pressed("Jump"):
		target_velocity.y = jump_acceleration

	# ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# vertical velocity
	if not is_on_floor(): # If in the air, fall towards the floor
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# running
	if is_on_floor() and Input.is_action_pressed("Running"):
		speed = speed * 1.1
		speed = clamp(speed,14,28)
	else: speed = 14
	
	# moving the character
	velocity = target_velocity
	move_and_slide()
	
func _input(event):
	# camera
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# side-to-side
		rotate_y(-event.relative.x * mouse_sensitivity)
		# up and down
		$CameraFirstPerson/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraFirstPerson/Camera3D.rotation.x = clampf($CameraFirstPerson/Camera3D.rotation.x,-deg_to_rad(70),deg_to_rad(70))

func _process(delta):
	if !is_on_floor() and Input.is_action_pressed("Gravity Hold"):
		fall_acceleration = 10
	else: if !is_on_floor() and Input.is_action_pressed("Gravity Fall"):
		fall_acceleration = 500
	else: fall_acceleration = 75
		
