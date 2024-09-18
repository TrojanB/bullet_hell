extends Control

@onready var play_again_button = $ColorRect/Play_Again_Button
@onready var main_menu_button = $ColorRect/Main_Menu_Button


func _on_play_again_button_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
	print("GAME OVER")


func _on_main_menu_button_button_up():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
