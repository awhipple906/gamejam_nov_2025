extends Node
class_name EnemyMovementAnimations

var animation
var last_animation = "move"
var current_face = "L"

func set_animation(animated_sprite):
	animation = animated_sprite

func play_movement_animations(velocity):
	if animation == null or animation.is_playing():
		return
	else:

		if velocity.z < 0:
			animation.flip_h = true
			last_animation = "move"
			current_face = "R"

		elif velocity.z > 0:
			animation.flip_h = false
			last_animation = "move"
			current_face = "L"
		
		animation.play(last_animation)

func play_attack_animation():
	if current_face == "R":
		animation.flip_h = true
	else:
		animation.flip_h = false
	animation.play("attack")
