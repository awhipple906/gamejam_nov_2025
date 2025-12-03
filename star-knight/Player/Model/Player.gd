extends CharacterBody3D
class_name Player

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var hitbox : HitboxComponent
@export var attack_stats : MeleeAttackStats
@export var chitlabel : RichTextLabel

@export var rangedBullet : PackedScene

# Audio for player actions
@export var step_sfx : AudioStream
@export var jump_sfx : AudioStream
@export var showint : Label3D
signal pressingInteract
var step_frames : Array = [0,4]

var target_velocity = Vector3.ZERO
var last_animation = "idle"
var health
var chits
var isChatting = false
var attacking = false

var spawn_point = Vector3(0, 0, 0)

func _ready() -> void:
	hitbox.health_component.MAX_HEALTH = PlayerVar.playerMaxHealth
	hitbox.health_component.health = PlayerVar.playerCurrentHealth
	health = hitbox.health_component.health
	speed = PlayerVar.playerMoveSpeed
	attack_stats.damage = PlayerVar.playerMeleeDamage
	attack_stats.attack_cooldown = PlayerVar.playerCoolDown
	

	Dialogic.timeline_started.connect(Dialogicstarted)
	Dialogic.timeline_ended.connect(Dialogicended)
	InteractEmitter.connect("CanInteract", showlabel)
	InteractEmitter.connect("CantInteract", hidelabel)
	
	spawn_point = self.global_transform.origin


func _physics_process(delta):
	_check_height()
	if global_position == Vector3(0,-20,0):
		respawn()
	
	if Input.is_action_just_pressed("secondary_attack"):
		_shoot()
		
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector(
		"Left", "Right", "Forward", "Back"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)

	var direction = transform.basis * input_direction_3D
	#print(direction)
	play_animation()
	
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("interact"):
		print("Interacting!")
		pressingInteract.emit()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0 
		%jump_player.play()
		%PlayerSprite3D.stop()
		%PlayerSprite3D.play("jump")
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	elif Input.is_action_just_pressed("primary_attack") and !isChatting and !attacking:
		%PlayerSprite3D.stop()
		%PlayerSprite3D.play("attack")
		attacking = true
		if attack_stats.has_overlapping_bodies():
			_hit_enemies(attack_stats.get_overlapping_bodies())
		await get_tree().create_timer(0.5).timeout
		attacking = false

	if isChatting == false:
		move_and_slide()
	
	
func play_animation():
	if attacking:
		return
	if velocity == Vector3.ZERO and !%PlayerSprite3D.is_playing() and is_on_floor():
		%PlayerSprite3D.play("idle")
	if isChatting:
		%PlayerSprite3D.play("idle")
	if velocity.x < 0 and !isChatting and is_on_floor():
		%PlayerSprite3D.play(last_animation)
	if velocity.z < 0 and !isChatting and is_on_floor():
		%PlayerSprite3D.flip_h = false
		%PlayerSprite3D.play("walk")
	if velocity.x > 0 and !isChatting and is_on_floor():
		%PlayerSprite3D.play(last_animation)
	if velocity.z > 0 and !isChatting and is_on_floor():
		%PlayerSprite3D.flip_h = true
		%PlayerSprite3D.play("walk")
	if velocity.y == 0 and !Input.is_anything_pressed() and is_on_floor():
		%PlayerSprite3D.play("idle")
	last_animation = "walk"

			
func _hit_enemies(enemies : Array):
	var count = 0
	for enemy in enemies:
		if(enemies[count].is_in_group("Enemies")):
			attack_stats._do_attack(enemy)
			enemy.velocity = Vector3(randf_range(-PI / 4, PI / 4) * 10, 1, randf_range(-PI / 4, PI / 4) * 10)
			print("HITTING " + str(enemy))
		count += 1

func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load

func _on_player_sprite_3d_frame_changed():
	if %PlayerSprite3D.animation == 'idle': return
	if %PlayerSprite3D.animation == 'jump': return
	load_sfx(step_sfx)
	if %PlayerSprite3D.frame in step_frames and is_on_floor(): %sfx_player.play()

func Dialogicstarted():
	isChatting = true

func Dialogicended():
	isChatting = false

func showlabel():
	showint.show()
	print("Press e")
func hidelabel():
	showint.hide()

func _shoot ():
	%TherggAttackAudio.play()
	var bullet = rangedBullet.instantiate()
	get_parent().get_parent().add_sibling(bullet)
	bullet.position = %SpawnBlock.global_position
	var dir = bullet.position.direction_to(%RayCast3D.get_collision_point())
	bullet.global_rotation = %RayCast3D.get_collision_point() - bullet.position.normalized()
	bullet.target_pos = dir
	attack_stats.isOnCoolDown = true

func respawn():
	self.global_position = spawn_point
	velocity = Vector3.ZERO
	
func _check_height():
	if position.y < -100:
		respawn()
