extends Control

@onready var scroll_container = $ScrollContainer
@onready var inventory_contianer = $ScrollContainer/Inventory
@onready var equipped_weapons_contaier = $ScrollContainer/Inventory/Panel/EquippedWeaponsContaier
@onready var player_weapons : Array[weapon_card] = Gm.player_weapons
var card_pattern = load("res://scenes/Card_Scenes/weapon_card.tscn")
var selected_card = null

func _ready():
	#_add_space_holder(Vector2(150,40))
	for weapon in player_weapons:
		var card = card_pattern.instantiate()
		card.weapon = weapon
		card.connect("pressed", Callable(self, "_on_card_pressed").bind(card))
		inventory_contianer.add_child(card)
		
	for slot in equipped_weapons_contaier.get_children():
		slot.connect("slot_pressed", Callable(self, "on_slot_pressed").bind(slot))

func _add_space_holder(s : Vector2):
	var space_holder = Control.new()
	space_holder.custom_minimum_size = s
	inventory_contianer.add_child(space_holder)
	
func _on_card_pressed(new_card):
	print("ONCARD")
	if selected_card and selected_card != new_card and not selected_card.roll_down_bool:
		selected_card.roll_up()
	selected_card = new_card

func _on_slot_pressed(slot):
	if selected_card:
		
