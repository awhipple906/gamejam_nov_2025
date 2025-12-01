extends Node3D

var roomConstants = RoomConstants.new()

@onready var current_scene = get_tree().current_scene.name
var next_scene
var next_scene_index
@onready var closeToDoor = false
@onready var pressingE = false

func _ready():
	%Player.hitbox.health_component.health = PlayerVar.playerMaxHealth
	PlayerVar.playerCurrentHealth = PlayerVar.playerMaxHealth
	if Dialogic.VAR.HasSeen == false:
		run_dialogue("HubFirstConvo")
		
	InteractEmitter.connect("CanInteract", setnear)
	InteractEmitter.connect("CantInteract", setfar)
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
		next_scene_index = randi_range(0, roomConstants.Rooms.size() -1)
		next_scene = roomConstants.Rooms[next_scene_index]

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _process(delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_E):
		pressingE = true
	else:
		pressingE = false
	if(pressingE and closeToDoor):
		_change_scene()

func _physics_process(_delta: float) -> void:
	if(!%Player):
		print("NO PLAYER DETECTED")
		return
	get_tree().call_group("Enemies", "update_target_location", %Player.global_transform.origin)

func _change_scene():
	var sceneParser = "res://Rooms/" + str(next_scene) + ".tscn"
	print(sceneParser)
	get_tree().change_scene_to_file(sceneParser)

func setnear():
	closeToDoor = true
func setfar():
	closeToDoor = false
