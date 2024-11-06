extends Node

var COMMON_WEAPONS : Array[weapon_card] = [
	weapon_card.new("PISTOL_01", 10, 0.5, 100, 1, Gm.rarities.COMMON, 1),
	weapon_card.new("RIFLE_01", 30, 0.2, 100, 1, Gm.rarities.COMMON, 1),
	weapon_card.new("SMG_01", 20, 0.1, 100, 1, Gm.rarities.COMMON, 1)
]

func get_random_card():
	print("ACTIVATED")
	var random_index = randi() % COMMON_WEAPONS.size()
	return COMMON_WEAPONS[random_index]
