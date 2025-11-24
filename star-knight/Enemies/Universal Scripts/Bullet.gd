extends Area3D
class_name Bullet
var bullet_destination

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Bullet Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!bullet_destination):
		return
	position += bullet_destination * delta
	
func set_destination(target_location):
	bullet_destination = target_location
