extends Control

var card_pattern = preload("res://scenes/Card_Scenes/weapon_card.tscn")
var cards = preload("res://scenes/Card_Scenes/CARDS.gd")

@export var taps_to_open : int = 8
signal tapped
signal pack_opened
var pack_opend : bool = false

func _gui_input(event):
	if (taps_to_open > 0) and (event is InputEventScreenTouch and event.is_pressed() or event is InputEventMouseButton and event.is_pressed()):
		taps_to_open -= 1
		tapped.emit()
	elif (taps_to_open <= 0) and not pack_opend and (event is InputEventScreenTouch and event.is_pressed() or event is InputEventMouseButton and event.is_pressed()):
		pack_opened.emit()

func _on_pack_opened():
	pack_opend = true
	var cards_script = cards.new()
	var card = card_pattern.instantiate()
	var random_card : weapon_card = cards_script.get_random_card()
	
	card.weapon = random_card
	add_child(card)
	card.position = Vector2(27.5,40)
	card.get_node("AnimationPlayer").play("pop_up")
	card.mouse_filter = MOUSE_FILTER_IGNORE
