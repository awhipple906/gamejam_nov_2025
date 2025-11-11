extends Node
class_name EnemyMovementAnimations

var animation
var last_animation = "idle"
var current_face = ""
func set_animation(animated_sprite):
	animation = animated_sprite

func play_movement_animations(velocity):
	if animation == null:
		return
	else:
		if velocity.x < 0:
			animation.play(last_animation)
		if velocity.z < 0:
			animation.flip_h = true
			animation.play("move")
			last_animation = "move"
			current_face = "R"
		if velocity.x > 0:
			animation.play(last_animation)
		if velocity.z > 0:
			animation.flip_h = false
			animation.play("move")
			last_animation = "move"
			current_face = "L"

func play_attack_animations():
	if current_face == "R":
		animation.flip_h = true
		animation.play("attack")
	else:
		animation.flip_h = false
		animation.play("attack")
