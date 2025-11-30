extends Node


@onready var player = %Player
@onready var mesh = %NavigationRegion3D
var roomConstants = RoomConstants.new()

@onready var current_scene = get_tree().current_scene.name
var next_scene : PackedScene
var next_scene_index

func _ready() -> void:
	print(current_scene)
	##Tutorial Rooms will go in sequence
	if current_scene in roomConstants.TutorialRooms:
		next_scene_index = roomConstants.TutorialRooms.find(current_scene,0) + 1
		if (next_scene_index > roomConstants.TutorialRooms.size()):
			next_scene = current_scene
		else:
			next_scene = roomConstants.TutorialRooms[next_scene_index]
		print(next_scene)
	##Any other room will randomly proceed current room
	elif  current_scene in roomConstants.Rooms:
		next_scene_index = roomConstants.Rooms.find(current_scene,0) + randi_range(0, roomConstants.Rooms.size())
		next_scene = roomConstants.Rooms[next_scene_index]
#Called logic in every room so the enemies can know where the player is.
func _physics_process(delta: float) -> void:
	if(!player):
		print("NO PLAYER DETECTED")
		return
	get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)

#func _change_scene():
	#if (%Player.pressingInteract && Door.canEnterDoor):
		#change scene
