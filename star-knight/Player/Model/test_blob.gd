extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var last_animation = "idle"
func _physics_process(delta):
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector(
		"Left", "Right", "Forward", "Back"
	)
	#print(input_direction_2D)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	#print(direction)
	play_animation(direction)
	
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	#var direction = Vector3.ZERO
	#
	#if Input.is_action_pressed("Right"):
		#print("I am pushing: RIGHT")

	#if Input.is_action_pressed("Left"):
		#print("I am pushing: LEFT")
		#direction.x -= 1
	#if Input.is_action_pressed("Back"):
		#print("I am pushing: BACK")
		#direction.z += 1
	#if Input.is_action_pressed("Forward"):
		#print("I am pushing: FORWARD")
		#direction.z -= 1
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	elif Input.is_action_just_pressed("primary_attack"):
		swing(direction)
	
	move_and_slide()
	
	
func play_animation(direction):
	#var last_pressed = Input.
	if !Input.is_anything_pressed():
		$PlayerSprite3D.play("idle")
	if direction.x == -1:
		$PlayerSprite3D.play(last_animation)
	if direction.z == -1:
		$PlayerSprite3D.play("left to right")
		last_animation = "left to right"
	if direction.x == 1:
		$PlayerSprite3D.play(last_animation)
	if direction.z == 1:
		$PlayerSprite3D.play("right to left")
		last_animation = "right to left"
	
func swing(direction):
		var attack_angle = direction.z
		print("Attack angle: " + str(attack_angle))
		if attack_angle < 0:
			print("Attacking Right")
		else:
			print("Attacking Left")
