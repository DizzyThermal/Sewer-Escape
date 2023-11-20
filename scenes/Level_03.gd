extends Node2D

var WATER_WIDTH = 482
var WATER_HEIGHT = 224
var currentHeight = WATER_HEIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() != "Android":
		$Camera2D/MobileControls.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_next_area_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_water_timer_timeout():
	$Foreground/Water.set_size(Vector2(WATER_WIDTH, currentHeight))
	currentHeight += 1
	$Foreground/Water.global_position.y -= 1
	$Foreground/DeathZoneLevel3/CollisionShape2D.global_position.y -= 1 
