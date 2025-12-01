extends Node3D


func _ready():
	%Player.hitbox.health_component.health = %Player.hitbox.health_component.MAX_HEALTH
	if Dialogic.VAR.HasSeen == false:
		run_dialogue("HubFirstConvo")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)