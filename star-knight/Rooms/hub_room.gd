extends Node3D


func _ready():
	if Dialogic.VAR.HasSeen == false:
		run_dialogue("HubFirstConvo")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
