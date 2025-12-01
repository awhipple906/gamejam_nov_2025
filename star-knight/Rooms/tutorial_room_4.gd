extends Node3D


@onready var player = %Player
@onready var mesh = %NavigationRegion3D
var roomConstants = RoomConstants.new()

@onready var current_scene = get_tree().current_scene.name
var next_scene
var next_scene_index
@onready var closeToDoor = false
@onready var pressingE = false


func _ready():
	InteractEmitter.connect("CanInteract", setnear)
	InteractEmitter.connect("CantInteract", setfar)
	run_dialogue("TutorialRoom4")

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

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

#Called logic in every room so the enemies can know where the player is.
func _physics_process(_delta: float) -> void:
	if(!player):
		print("NO PLAYER DETECTED")
		return
	get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)

func _change_scene():
	var sceneParser = "res://Rooms/" + next_scene + ".tscn"
	print(sceneParser)
	get_tree().change_scene_to_file(sceneParser)

func _on_player_pressing_interact():
	pressingE = true

func _process(delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_E):
		pressingE = true
	else:
		pressingE = false

	
	if(pressingE and closeToDoor):
		_change_scene()


func setnear():
	closeToDoor = true
func setfar():
	closeToDoor = false
