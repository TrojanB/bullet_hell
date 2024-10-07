class_name Diamond

var rarity : Gm.diamond_rarities
var diamond_texture : Texture

func _init():
	rarity = _randomize_rarity()
	var rarity_index = Gm.diamond_rarities.values().find(rarity)
	diamond_texture = Gm.diamonds_textures[rarity_index]

func _randomize_rarity():
	var random_value = randi() % 1000
	print(random_value)

	if random_value <= 650:
		return Gm.diamond_rarities.BLUE
	elif random_value <= 850:
		return Gm.diamond_rarities.PURPLE
	elif random_value <= 950:
		return Gm.diamond_rarities.PINK
	else:
		return Gm.diamond_rarities.RED
