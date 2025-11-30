extends CharacterBody3D
class_name Player

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var hitbox : HitboxComponent

# Audio for player actions
@export var step_sfx : AudioStream
@export var jump_sfx : AudioStream
signal pressingInteract
var step_frames : Array = [0,4]

var target_velocity = Vector3.ZERO
var last_animation = "idle"
var health


func _ready() -> void:
	health = hitbox.health_component.health


func _physics_process(delta):
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector(
		"Left", "Right", "Forward", "Back"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)

	var direction = transform.basis * input_direction_3D
	#print(direction)
	if Dialogic.VAR.Ischatting == false:
		play_animation(direction)
	
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("Interact"):
		pressingInteract.emit()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0 
		%jump_player.play()
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	elif Input.is_action_just_pressed("primary_attack"):
		swing(direction)
	if Dialogic.VAR.Ischatting == false:
		move_and_slide()
	
	
func play_animation(direction):
	#var last_pressed = Input.
	if !Input.is_anything_pressed():
		%PlayerSprite3D.play("idle")
	if direction.x == -1:
		%PlayerSprite3D.play(last_animation)
	if direction.z == -1:
		%PlayerSprite3D.play("left to right")
		last_animation = "left to right"
	if direction.x == 1:
		%PlayerSprite3D.play(last_animation)
	if direction.z == 1:
		%PlayerSprite3D.play("right to left")
		last_animation = "right to left"


	
func swing(direction):
		var attack_angle = direction.z
		print("Attack angle: " + str(attack_angle))
		if attack_angle < 0:
			print("Attacking Right")
		else:
			print("Attacking Left")
			

func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load

func _on_player_sprite_3d_frame_changed():
	if %PlayerSprite3D.animation == 'idle': return
	if %PlayerSprite3D.animation == 'jump': return
	load_sfx(step_sfx)
	if %PlayerSprite3D.frame in step_frames and is_on_floor(): %sfx_player.play()
	
