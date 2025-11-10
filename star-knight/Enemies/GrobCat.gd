extends CharacterBody3D

@export var max_health:= 10.0
@export var max_speed := 5.0
@export var attack_range := 2.0

var stunned := false
var health
var isAttacking = false
var last_animation = "idle"

var current_speed := 0.0

@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:
	randomize()
	var player = get_node(".../test_blob.tscn")

#This is the Grobcat pathing to the player
func _physics_process(delta: float) -> void:
	var current_position = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * max_speed
	
	velocity = new_velocity

	if velocity.x < 0:
		$GrobCatSprite3d.play(last_animation)
	if velocity.z < 0:
		$GrobCatSprite3d.flip_h = (velocity.z < 0)
		print("FLIPPING ANIMATION>>>>>>")
		$GrobCatSprite3d.play("move")
		last_animation = "move"
	if velocity.x > 0:
		$GrobCatSprite3d.play(last_animation)
	if velocity.z > 0:
		$GrobCatSprite3d.flip_h = (velocity.z > 0)
		$GrobCatSprite3d.play("move")
		last_animation = "move"
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func target_in_range(player):
	return global_position.distance_to(player.global_position) < attack_range
	isAttacking = true
	$GrobCatSprite3d.play("bite")
	last_animation = "bite"
	
