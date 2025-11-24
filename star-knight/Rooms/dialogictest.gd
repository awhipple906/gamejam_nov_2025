extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	run_dialogue("TutorialRoom1")


func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
