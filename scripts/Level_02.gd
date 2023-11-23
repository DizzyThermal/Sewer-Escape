extends Node2D

func _ready():
	if OS.get_name() != "Android":
		$Camera2D/MobileControls.hide()
	else:
		$Camera2D.zoom.x *= 2
		$Camera2D.zoom.y *= 2

func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_next_area_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/Level_03.tscn")
