extends CharacterBody3D

signal damaged(attack: Attack)

@export var stats: EnemyStats

var max_speed : float
var variation_range : float
var acceleration_time : float
var friction : float

@onready var sprite: AnimatedSprite3D = $Sprite3D
#@onready var health : EnemyHealth = $HealthComponent

var alive := true
var stunned := false

var current_speed := 0.0

func _ready() -> void:
	randomize()
	#health.max_health = stats.max_health
	max_speed = stats.max_speed
	variation_range = stats.variation_range
	acceleration_time = stats.acceleration_time
	friction = stats.friction
	#sprite.t = stats.texture
