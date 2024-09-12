extends CharacterBody3D

# how fast the player moves
@export var speed = 14
# the downward acceleration when in the air
@export var fall_acceleration = 75
@export var jump_acceleration = 20
var mouse_sensitivity = 0.002

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var input = Input.get_vector("Left","Right","Forwards","Backwards")
	var direction = transform.basis * Vector3(input.x,0.0,input.y)
	
	if is_on_floor() and Input.is_action_pressed("Jump"):
		target_velocity.y = jump_acceleration

	# ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# coving the Character
	velocity = target_velocity
	move_and_slide()
	
func _input(event):
	# camera
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		#rotate_x(-event.relative.y * mouse_sensitivity)
