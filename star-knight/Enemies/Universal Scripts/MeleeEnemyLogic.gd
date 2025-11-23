extends CharacterBody3D


@export var max_speed := 5.0
@export var attack_range := 1.0
@export var EnemyHitboxComponent : HitboxComponent
@export var attack_stats : MeleeAttackStats
@export var animation : AnimatedSprite3D
var animation_player
var canCheckPhysics = true
var stunned := false
var current_speed := 0.0
var Is_chatting = false

@onready var nav_agent = $NavigationAgent3D
@onready var physicsCheckNum = int(randf_range(2,30))
@onready var max_health = EnemyHitboxComponent.health_component.health


func _ready() -> void:
	randomize()
	add_to_group("Enemies")
	animation_player = EnemyMovementAnimations.new()
	animation_player.set_animation(animation)
	print("Physics Num:" + str(physicsCheckNum))
	Dialogic.signal_event.connect(_on_dialogic_signal)

#This is the Enemy pathing to the player
func _physics_process(delta: float) -> void:
	#Small if statement to ensure we aren't checking physics every single second and tanking our machines
	#also ensure when the enemy spawns they are set to random interval so they aren't checking the same second
	#as all other enemies.
	if(int(delta)%physicsCheckNum == 0):
		canCheckPhysics = true
	else:
		canCheckPhysics = false
	if(canCheckPhysics):
		#if we are touching the player start to attack and stop moving
		if(attack_stats._check_can_attack(attack_stats) and attack_stats.get_overlapping_bodies().count(%Player) > 0):
			velocity = Vector3(0,0,0)
			animation_player.play_attack_animation()
			attack_stats._do_attack(%Player)
		#if we aren't attacking, we are out of range and are moving instead

		if(!attack_stats._check_can_attack(attack_stats) and !stunned and !animation.is_playing() and attack_stats.get_overlapping_bodies().count(%Player) == 0):
			velocity = calculate_path()
			animation_player.play_movement_animations(velocity)
			if Is_chatting == false:
				move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location


func calculate_path() -> Vector3:
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	return new_velocity
	
func _on_dialogic_signal(argument:String):
	if argument == "Ischatting":
		Is_chatting = true
	elif argument == "Notchatting":
		Is_chatting = false
