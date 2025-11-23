extends RigidBody3D
class_name Laser

@export var speed = 5.0
var target_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!target_pos):
		return
	move_and_collide(target_pos * delta * speed)
	pass

func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func _on_area_3d_body_entered(body: Node3D) -> void:
	queue_free()
	#print("I have collided with something")
	pass # Replace with function body.
