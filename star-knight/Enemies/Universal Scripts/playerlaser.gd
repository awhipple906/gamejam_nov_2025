extends RigidBody3D
class_name PlayerLaser

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

func _on_area_3d_body_entered(_body: Node3D) -> void:
	if _body.is_in_group("Enemies"):
		var attack = Attack.new()
		attack.attack_damage = 2.0
		_body.hitbox.damage(attack)
	else :
		queue_free()
	queue_free()
	#print("I have collided with something")
	pass # Replace with function body.
