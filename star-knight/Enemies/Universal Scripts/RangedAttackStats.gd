extends Area3D
class_name RangedAttackStats

@export var damage := 5.0
@export var max_peirce:= 1
@export var knockback_force := 1.0
@export var attack_cooldown := 5.0
@export var attack_range := 25.0
@export var attack_hitbox : CollisionShape3D
@export var bullet: Laser
var isOnCoolDown = false

func _check_can_attack(attack_stats : RangedAttackStats):
	if(!target_out_of_range(%Player) and !attack_stats.isOnCoolDown):
		return true
	else:
		return false


func _fire_bullet(target_location):
	bullet = Laser.new()
	bullet.target_location = target_location
	bullet.global_transform = global_transform
	isOnCoolDown = true
	return bullet
	await cooling_down()

func target_out_of_range(target):
	if !target:
		return
	return global_position.distance_to(target.global_position) < attack_range

func cooling_down():
	await get_tree().create_timer(attack_cooldown).timeout
	isOnCoolDown = false
