extends Node3D

@onready var player = %Player
@onready var mesh = %NavigationRegion3D


func _ready():
	run_dialogue("TutorialRoom3")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

#Called logic in every room so the enemies can know where the player is.
func _physics_process(delta: float) -> void:
	if(!player):
		print("NO PLAYER DETECTED")
		return
	get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)