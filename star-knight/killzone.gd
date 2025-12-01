extends Node3D






func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://Rooms/LoseScreen.tscn")
