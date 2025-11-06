extends Resource
class_name WeaponStats


@export_group("Attack")
@export var speed := 200.0
@export var damage := 5.0
@export var max_peirce:= 1
@export var knockback_force := 1.0

func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
	
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.knockback_force = knockback_force
	
		hitbox.damage(attack)
