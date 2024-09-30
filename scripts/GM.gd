extends Node

var last_completed_level : int = 3

enum game_mode {KILL_AMOUNT,SURVIVE_TIME,KILL_AMOUNT_TIME,KILL_BOSS}

var diamonds_textures : Array[Texture] = [
	preload("res://GameSprites/DIAMONDS/blue_diamond.png"),
	preload("res://GameSprites/DIAMONDS/pink_diamond.png"),
	preload("res://GameSprites/DIAMONDS/purple_diamond.png"),
	preload("res://GameSprites/DIAMONDS/red_diamond.png")
]

@export var diamond : PackedScene = preload("res://scenes/Diamonds_scenes/diamond_body.tscn")
