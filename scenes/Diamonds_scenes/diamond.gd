extends Area2D

@onready var diamond_sprite = $DiamondSprite

var diamonds : Array[Texture] = [
	preload("res://GameSprites/DIAMONDS/blue_diamond.png"),
	preload("res://GameSprites/DIAMONDS/pink_diamond.png"),
	preload("res://GameSprites/DIAMONDS/purple_diamond.png"),
	preload("res://GameSprites/DIAMONDS/red_diamond.png")
]

func _ready():
	apply_texture()

func apply_texture():
	var diamond_texture = diamonds[randf_range(0, diamonds.size()-1)]
	diamond_sprite.texture = diamond_texture

