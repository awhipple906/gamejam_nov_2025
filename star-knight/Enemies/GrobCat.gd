extends CharacterBody3D

@export var max_health:= 10.0
@export var max_speed := 5.0
@export var attack_range := 2.0
@export var animation : AnimatedSprite3D
var animation_player
var player

var stunned := false
var health
var isAttacking = false
var last_animation = "idle"

var current_speed := 0.0

@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:
	randomize()
	player = %test_blob
	print(player)
	animation_player = EnemyMovementAnimations.new()
	animation_player.set_animation(animation)

#This is the Grobcat pathing to the player
func _physics_process(delta: float) -> void:
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	
	velocity = new_velocity
	animation_player.play_movement_animations(velocity)
	if (target_in_range()):
		animation_player.play_attack_animations()
		print("Attacking!")
	else:
		print("Not Attacking!")

	move_and_slide()

		
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func target_in_range():
	if !player:
		return
	return global_position.distance_to(player.global_position) < attack_range
	
