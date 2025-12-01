extends Node3D
var roomConstants = RoomConstants.new()

@onready var current_scene = get_tree().current_scene.name
var next_scene
var next_scene_index
@onready var closeToDoor = false
@onready var pressingE = false


func _ready():
	run_dialogue("TutorialRoom1")
	print(current_scene)
	##Tutorial Rooms will go in sequence
	if current_scene in roomConstants.TutorialRooms:
		next_scene_index = roomConstants.TutorialRooms.find(current_scene,0) + 1
		if (next_scene_index > roomConstants.TutorialRooms.size()):
			next_scene = "HubRoom"
		else:
			next_scene = roomConstants.TutorialRooms[next_scene_index]
		print(next_scene)
	##Any other room will randomly proceed current room
	elif  current_scene in roomConstants.Rooms:
		next_scene_index = roomConstants.Rooms.find(current_scene,0) + randi_range(0, roomConstants.Rooms.size())
		next_scene = roomConstants.Rooms[next_scene_index]

func _process(delta: float) -> void:
	if(pressingE and closeToDoor):
		_change_scene()

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func _change_scene():
	var sceneParser = "res://Rooms/" + next_scene + ".tscn"
	print(sceneParser)
	get_tree().change_scene_to_file(sceneParser)

func _on_door_can_enter_door():
	closeToDoor = true

func _on_player_pressing_interact():
	pressingE = true
