extends Control

@onready var play_button = $Background/PlayButton
@onready var weapons_button = $Background/WeaponsButton
@onready var customize_button = $Background/CustomizeButton

func _on_play_button_button_up():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
