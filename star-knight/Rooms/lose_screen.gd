extends Node2D




func _on_hub_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Rooms/HubRoom.tscn")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Rooms/MainMenu.tscn")
