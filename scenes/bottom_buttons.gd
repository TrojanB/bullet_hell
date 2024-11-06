extends HBoxContainer

func _on_weapons_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gun_shop.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
