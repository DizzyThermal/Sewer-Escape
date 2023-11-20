extends Node2D

var WATER_WIDTH = 1953
var WATER_HEIGHT = 520
var currentHeight = WATER_HEIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_water_timer_timeout():
	$Foreground/Water.set_size(Vector2(WATER_WIDTH, currentHeight))
	currentHeight += 1
	$Foreground/Water.global_position.y -= 1
	$Foreground/DeathZone/CollisionShape2D.global_position.y -= 1
