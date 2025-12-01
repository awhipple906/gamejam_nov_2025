extends Node3D


@export var teekomenu: Window
var player_in_area = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area == true:
		if Input.is_action_just_pressed("e"):
			if Dialogic.VAR.HasTalkedTeeko == false:
				Dialogic.timeline_ended.connect(_on_timeline_ended)
				run_dialogue("TeekoConvo")

			elif Dialogic.VAR.HasTalkedTeeko == true:	
				teekomenu.show()
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.has_method("swing"):
		player_in_area = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("swing"):
		player_in_area = true

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	teekomenu.show()
