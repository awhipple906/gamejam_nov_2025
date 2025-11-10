extends Node3D



@export var stats : WeaponStats
@export var camera_shake_amount : float = 15.0

var attacking_entity = null

var melee_swing : PackedScene = preload("res://MeleeSwing.tscn")
# Called when the node enters the scene tree for the first time.
var is_cooldown := false
var cooldown_timer : Timer

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.name = "Cooldown Timer"
	cooldown_timer.wait_time = stats.firing_cooldown


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("primary_attack") && !is_cooldown:
		melee_swing.instantiate()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_attacker(entity: CharacterBody3D):
	attacking_entity = entity
