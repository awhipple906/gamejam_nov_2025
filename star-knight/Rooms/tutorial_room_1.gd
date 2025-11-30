extends Node3D


func _ready():
	run_dialogue("TutorialRoom1")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
