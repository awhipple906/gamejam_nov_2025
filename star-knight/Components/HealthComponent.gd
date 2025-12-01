extends Node3D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health: float
@onready var parent = get_parent()
signal healthChanged
var canGetHit = true

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	healthChanged.emit()
	health -= attack.attack_damage
	%hitflashanimation.play("hit")
	if canGetHit:
		%sfx_hit.play()
	print("New health value of my parent: " + str(health))
	if parent is Player and canGetHit: 
		PlayerVar.playerCurrentHealth -= attack.attack_damage
		%dmg_player.play()
	if health <= 0 and parent is Player:
		canGetHit = false; 
		print("DEAD")
		PlayerVar.emit_signal("losechits")
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://Rooms/LoseScreen.tscn")
	elif health <= 0 and parent.is_in_group("Enemies"):
		PlayerVar.emit_signal("getchits")
		get_parent().queue_free()
