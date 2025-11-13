extends Area3D
class_name AttackStats

#@export_group("Attack")
@export var speed := 200.0
@export var damage := 5.0
@export var max_peirce:= 1
@export var knockback_force := 1.0
@export var attack_cooldown := 5.0
var isOnCoolDown = false
var attack_hit_box : CollisionShape3D

func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		print("HITBOX ENTERED")
		var hitbox : HitboxComponent = area
	
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.knockback_force = knockback_force
		
		print("Dealing: " + str(damage) + " to Player")
		hitbox.damage(attack)


func _do_attack(body: Node3D) -> void:
	if body is Player and !isOnCoolDown:
		print("HITBOX ENTERED")
		var hitbox : HitboxComponent = body.playerHitboxComponent
		
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.knockback_force = knockback_force
		print("Dealing: " + str(damage) + " to Player")
		hitbox.damage(attack)
		isOnCoolDown = true
	await cooling_down()

func cooling_down():
	await get_tree().create_timer(attack_cooldown).timeout
	isOnCoolDown = false
