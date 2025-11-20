extends Area3D
class_name MeleeAttackStats

#@export_group("Attack")
@export var speed := 200.0
@export var damage := 5.0
@export var max_peirce:= 1
@export var knockback_force := 1.0
@export var attack_cooldown := 5.0
@export var attack_range := 1.0
@export var attack_hitbox : CollisionShape3D
var isOnCoolDown = false

func _check_can_attack(attack_stats : MeleeAttackStats):
	if(attack_stats.has_overlapping_bodies() and !target_out_of_range(%Player) and !attack_stats.isOnCoolDown):
		return true
	else:
		return false


func _do_attack(body: Node3D) -> void:
	var hitbox : HitboxComponent
	var attack = Attack.new()
	attack.attack_damage = damage
	attack.knockback_force = knockback_force
	if body is Player and !isOnCoolDown:
		print("PLAYER HITBOX ENTERED")
		hitbox = body.playerHitboxComponent
		print("Dealing: " + str(damage) + " to Player")
		hitbox.damage(attack)
		isOnCoolDown = true
	elif body.get_groups().has("Enemies") and !isOnCoolDown:
		print("ENEMY HITBOX ENTERED")
		hitbox = body.EnemyHitboxComponent
		print("Dealing: " + str(damage) + " to Enemy")
		hitbox.damage(attack)
		isOnCoolDown = true

	await cooling_down()

func target_out_of_range(target):
	if !target:
		return
	return global_position.distance_to(target.global_position) > attack_range

func cooling_down():
	await get_tree().create_timer(attack_cooldown).timeout
	isOnCoolDown = false
