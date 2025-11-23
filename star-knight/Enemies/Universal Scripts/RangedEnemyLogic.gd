extends CharacterBody3D


@export var max_speed := 5.0
@export var hitbox : HitboxComponent
@export var attack_stats : RangedAttackStats
@export var animation : AnimatedSprite3D
@export var rangedBullet : PackedScene
var animation_player
var canCheckPhysics = true
var stunned := false
var current_speed := 0.0
var walking = false

@onready var nav_agent = $NavigationAgent3D
@onready var physicsCheckNum = int(randf_range(2,30))
@onready var max_health = hitbox.health_component.health


func _ready() -> void:
	randomize()
	add_to_group("Enemies")
	animation_player = EnemyMovementAnimations.new()
	animation_player.set_animation(animation)
	print("Physics Num:" + str(physicsCheckNum))
	attack_stats.isOnCoolDown =  false

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
		if(!%Player):
			return
		#if we are in safe range of player start to attack and stop moving
		if(position.distance_to(%Player.global_position) >= attack_stats.attack_range/2):
			walking = false
			velocity = Vector3.ZERO
			animation_player.play_attack_animation()
			if (!attack_stats.isOnCoolDown):
				_shoot()
				attack_stats.isOnCoolDown = true
				await attack_stats.cooling_down()
				attack_stats.isOnCoolDown = false
		#if we aren't attacking, we are out of range and are moving instead

		if(position.distance_to(%Player.global_position) < attack_stats.attack_range/2 and velocity == Vector3.ZERO):
			animation.stop()
			velocity = calculate_path()
			if(velocity != Vector3.ZERO):
				animation_player.play_movement_animations(velocity)
			walking = true
			await get_tree().create_timer(1.0).timeout
		
		
			#_walk_till_stop(position, nav_agent.target_position)
			#velocity = calculate_path()
		#print("Are we Walking? " + str(walking))
		move_and_slide()

func update_target_location(target_location:Vector3):
	#await get_tree().create_timer(3.0).timeout
	#nav_agent.target_position = target_location * Vector3(randf_range(-1,TAU),1,randf_range(-1,TAU)).normalized()
	if (!walking):
		nav_agent.target_position = target_location
		#print("Walking at this speed: " + str(velocity))
		#print("Walking to this location: " + str(nav_agent.target_position))
	
	#if velocity == Vector3.ZERO and canWalk:
		#nav_agent.target_position = Vector3(randfn(0,1),1,randfn(0,1)).normalized()


func calculate_path() -> Vector3:
	var current_position = position
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	return new_velocity

func _move ():
	if (velocity != Vector3.ZERO):
		return false
	else:
		return true
	
func _shoot ():
	var bullet = rangedBullet.instantiate()
	print(get_parent().get_parent())
	get_parent().get_parent().add_sibling(bullet)
	bullet.position = %SpawnBlock.global_position
	var dir = bullet.position.direction_to(%Player.global_position)
	#dir.x = (dir.x * 1.25)
	bullet.global_rotation = %Player.global_position - bullet.position.normalized()
	bullet.target_pos = dir
	#print("Where I am shootin" + str(bullet.target_pos))
	#print("Where I am at" + str(bullet.position))
	attack_stats.isOnCoolDown = true
	print()
	
	
