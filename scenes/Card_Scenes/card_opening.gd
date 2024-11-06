extends Control

var card_pattern = preload("res://scenes/Card_Scenes/weapon_card.tscn")
var cards = preload("res://scenes/Card_Scenes/CARDS.gd")

func _on_card_pack_pack_opened():
	var cards_script = cards.new()
	var card = card_pattern.instantiate()
	var random_card : weapon_card = cards_script.get_random_card()
	
	card.weapon = random_card
	add_child(card)
	card.get_node("AnimationPlayer").play("pop_up")
