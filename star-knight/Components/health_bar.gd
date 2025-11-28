extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
var body
func _ready() -> void:
	body = get_parent().get_parent().get_parent().get_parent()
	print(body.hitbox)
	body.hitbox.health_component.healthChanged.connect(update)
	max_value = body.hitbox.health_component.MAX_HEALTH
	value = max_value
	pass

func update():
	if (!body):
		return
	value = body.hitbox.health_component.health * 100 / body.hitbox.health_component.MAX_HEALTH
