extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D

var mousePosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("secondary_attack"):
		mousePosition = get_viewport().get_mouse_position()
		print(mousePosition)
		ray_cast_3d.target_position = project_local_ray_normal(mousePosition) * 100
		print(ray_cast_3d.target_position)
		ray_cast_3d.force_raycast_update()
		if ray_cast_3d.is_colliding():
			print("colliding")
			if ray_cast_3d.is_colliding() == true:
				ray_cast_3d.get_collision_point()
				print(ray_cast_3d.get_collision_point())
			
