extends Control

func _on_main_menu_button_button_up():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")


func _on_play_again_button_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
