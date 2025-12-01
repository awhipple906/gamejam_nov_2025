extends Window

@export var MeleeDamageLabel: RichTextLabel
@export var MoveSpeedLabel: RichTextLabel
var damagecost = PlayerVar.damagecost
var speedcost = PlayerVar.movespeedcost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MoveSpeedLabel.set_text(str(speedcost) + (" Chits"))
	MeleeDamageLabel.set_text(str(damagecost) + (" Chits"))

func _on_move_speed_button_pressed() -> void:
	if PlayerVar.chits >= speedcost:
		PlayerVar.chits -= speedcost
		speedcost += 50
		PlayerVar.movespeedcost += 50
		MoveSpeedLabel.set_text(str(speedcost) + (" Chits"))
		%Player.speed += 1
		PlayerVar.playerMoveSpeed += 1
		if PlayerVar.chits <= 0:
			PlayerVar.chits = 0
		PlayerVar.emit_signal("chitchange")


func _on_melee_damage_button_pressed() -> void:
	if PlayerVar.chits >= damagecost:
		PlayerVar.chits -= damagecost
		damagecost += 50
		PlayerVar.damagecost += 50
		MeleeDamageLabel.set_text(str(damagecost) + (" Chits"))
		PlayerVar.playerMeleeDamage += 0.3
		%Player.attack_stats.damage += 0.3
		if PlayerVar.chits <= 0:
			PlayerVar.chits = 0
		PlayerVar.emit_signal("chitchange")

func _on_close_requested() -> void:
	hide()
