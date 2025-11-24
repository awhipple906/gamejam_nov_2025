extends Node3D
class_name MeleeTrap
@export var attack_stats : MeleeAttackStats
@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(attack_stats.has_overlapping_bodies()):
		if (attack_stats._check_can_attack(attack_stats, attack_stats.get_overlapping_bodies()[0])):
			print("Spike sees you")
			attack_stats._do_attack(attack_stats.get_overlapping_bodies()[0])
		
