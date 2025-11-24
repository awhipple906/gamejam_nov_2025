extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
var body
func _ready() -> void:
	body = get_parent().get_parent().get_parent()
	print(body.hitbox)
	body.hitbox.health_component.healthChanged.connect(update)
	max_value = body.hitbox.health_component.MAX_HEALTH
	value = max_value
	print("SETTING MAX HEALTH OF " + str(body) + " TO: " + str(value))
	#visible = false
	pass

func update():
	if (!body):
		print("NO BODY")
		return
	#visible = true
	value = body.hitbox.health_component.health * 100 / body.hitbox.health_component.MAX_HEALTH
	#await get_tree().create_timer(1.0).timeout 
	#visible = false
