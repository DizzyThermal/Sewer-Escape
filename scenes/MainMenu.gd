extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Level_01.tscn")

func _on_levels_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelSelect.tscn")

func _on_exit_pressed():
	get_tree().quit()
