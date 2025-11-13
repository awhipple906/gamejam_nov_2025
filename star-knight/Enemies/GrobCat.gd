extends CharacterBody3D

@export var max_health:= 10.0
@export var max_speed := 5.0
@export var attack_range := 1.0
@export var attack_stats : AttackStats
@export var animation : AnimatedSprite3D
var animation_player
var player
var canCheckPhysics = true
var isAttacking = false


var stunned := false
var health
var justAttacked = false

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
	#Small if statement to ensure we aren't checking physics every single second and tanking our machines
	if(int(delta)%10 == 0):
		canCheckPhysics = true
	else:
		canCheckPhysics = false
	
	if(canCheckPhysics):
		#if we are touching the player start to attack and stop moving
		if(attack_stats.has_overlapping_bodies() and !target_out_of_range() and !attack_stats.isOnCoolDown):
			velocity = Vector3(0,0,0)
			animation_player.play_attack_animation()
			print("WE ATTACKING YOU!")
			attack_stats._do_attack(attack_stats.get_overlapping_bodies()[0])

		#if we aren't attacking we are out of range and are moving instead
		if(target_out_of_range() and !stunned):
			velocity = calculate_path()
			animation_player.play_movement_animations(velocity)
			isAttacking = false
			
		move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location

func target_out_of_range():
	if !player:
		return
	return global_position.distance_to(player.global_position) > attack_range

func calculate_path() -> Vector3:
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	return new_velocity
	
