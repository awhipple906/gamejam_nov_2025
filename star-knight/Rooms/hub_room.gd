extends Node3D


func _ready():
	%Player.hitbox.health_component.health = PlayerVar.playerMaxHealth
	PlayerVar.playerCurrentHealth = PlayerVar.playerMaxHealth
	if Dialogic.VAR.HasSeen == false:
		run_dialogue("HubFirstConvo")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
