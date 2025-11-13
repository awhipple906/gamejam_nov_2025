extends Node3D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health: float

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0: 
		print("DEAD")
		get_parent().queue_free()
