extends Node


@onready var player = $test_blob

#Called logic in every room so the enemies can know where the player is.
func _physics_process(delta: float) -> void:
	if(!player):
		return
	get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)
