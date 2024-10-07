extends Label

@onready var diamond_texture = $TextureRect
@onready var animation_player = $AnimationPlayer

func _ready():
	text = "0"

func update_diamonds_label(diamonds, diamond_rarity):
	text = str(diamonds)
	var rarity_index = Gm.diamond_rarities.values().find(diamond_rarity)
	diamond_texture.texture = Gm.diamonds_textures[rarity_index]
	animation_player.play("diamond_collceted")
