extends Window

@onready var player = get_parent().get_node("/SubViewPortContainer/SubViewPort/Player")
@onready var health_component = get_parent().get_node("/SubViewPortContainer/SubViewPort/Player/HealthComponent")
@export var DamageLabel: RichTextLabel
@export var HealthLabel: RichTextLabel
@export var SpeedLabel: RichTextLabel
var damagecost = 50
var healthcost = 50
var speedcost = 50

# Called when the node enters the scene tree for the first time.





func _on_mind_damage_button_pressed() -> void:
	damagecost += 50
	DamageLabel.set_text(str(damagecost) + (" Chits"))

func _on_close_requested() -> void:
	hide()

func _on_health_button_pressed() -> void:
	healthcost += 50
	HealthLabel.set_text(str(healthcost) + (" Chits"))
	health_component.MAX_HEALTH += 5
	print(health_component.MAX_HEALTH)

func _on_mind_speed_button_pressed() -> void:
	speedcost += 50
	SpeedLabel.set_text(str(speedcost) + (" Chits"))
