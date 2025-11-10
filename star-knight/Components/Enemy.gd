extends CharacterBody3D

signal damaged(attack: Attack)


@export var ATTACK_RANGE := 2.0
@export var max_health:= 10.0
@export var armor := .05

@export var max_speed := 5.0

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var nav_agent = $NavigationAgent3D
#@onready var health : EnemyHealth = $HealthComponent

var alive := true
var stunned := false
var health
var taking_damage = false

var current_speed := 0.0
func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		queue_free()
	
	taking_damage = true
	velocity = (global_position - attack.attack_position).normalized()*attack.knockback_force
	
	attack.display_damage()

func _ready() -> void:
	randomize()
	var player = get_node("res://Player/Model/test_blob.tscn")
	health = max_health
	#health.max_health = stats.max_health
	#sprite.t = stats.texture

func _physics_process(delta: float) -> void:
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	
	velocity = new_velocity
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func target_in_range(player):
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
