extends Window

@export var MeleeDamageLabel: RichTextLabel
@export var MoveSpeedLabel: RichTextLabel
var damagecost = 50
var speedcost = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	

func _on_move_speed_button_pressed() -> void:
	speedcost += 50
	MoveSpeedLabel.set_text(str(speedcost) + (" Chits"))

func _on_melee_damage_button_pressed() -> void:
	damagecost += 50
	MeleeDamageLabel.set_text(str(speedcost) + (" Chits"))


func _on_close_requested() -> void:
	hide()
