extends Control

@onready var animation_player = $TextureRect/AnimationPlayer

func _on_card_opening_tapped():
	animation_player.play("tapped")

func _on_card_opening_pack_opened():
	animation_player.play("open")
