extends Window


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		show()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	if Dialogic.current_timeline:
		Dialogic.end_timeline()
	get_tree().change_scene_to_file("res://Rooms/MainMenu.tscn")




func _on_close_requested() -> void:
	hide()
	get_tree().paused = false

func _on_hub_button_pressed() -> void:
	get_tree().paused = false
	if Dialogic.current_timeline:
		Dialogic.end_timeline()	
	get_tree().change_scene_to_file("res://Rooms/HubRoom.tscn")
