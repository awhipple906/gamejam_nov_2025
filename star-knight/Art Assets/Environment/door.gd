extends Node3D
signal canEnterDoor

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		print("Player Spotted. Emitting Signal")
		canEnterDoor.emit()
