extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() != "Android":
		$Camera2D/MobileControls.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_next_area_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
