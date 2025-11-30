extends Node3D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health: float
@onready var parent = get_parent()
signal healthChanged

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	healthChanged.emit()
	health -= attack.attack_damage
	%hitflashanimation.play("hit")
	%sfx_hit.play()
	print("New health value of my parent: " + str(health))
	if parent is Player: 
		%dmg_player.play()
	if health <= 0: 
		print("DEAD")
		get_parent().queue_free()
