extends Window

@onready var player = get_parent().get_node("/SubViewPortContainer/SubViewPort/Player")
@onready var health_component = get_parent().get_node("/SubViewPortContainer/SubViewPort/Player/HealthComponent")
# Called when the node enters the scene tree for the first time.





func _on_mind_damage_button_pressed() -> void:
	pass # Replace with function body.

func _on_close_requested() -> void:
	hide()

func _on_health_button_pressed() -> void:
	health_component.MAX_HEALTH += 5
	print(health_component.MAX_HEALTH)
func _on_mind_speed_button_pressed() -> void:
	pass # Replace with function body.
