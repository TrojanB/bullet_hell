extends Node

var last_completed_level : int = 10
var diamonds : int = 0

enum game_mode {KILL_AMOUNT,SURVIVE_TIME,KILL_AMOUNT_TIME,KILL_BOSS}

@export var diamond : PackedScene = preload("res://scenes/Diamonds_scenes/diamond_body.tscn")

enum diamond_rarities {
	BLUE = 1,
	PURPLE = 2,
	PINK = 5,
	RED = 10
}

var diamond_chances : Array[int] = [
	50,
	40,
	5,
	1
]

var diamonds_textures : Array[Texture] = [
	preload("res://GameSprites/DIAMONDS/blue_diamond_v2.png"),
	preload("res://GameSprites/DIAMONDS/purple_diamond_v2.png"),
	preload("res://GameSprites/DIAMONDS/pink_diamond_v2.png"),
	preload("res://GameSprites/DIAMONDS/red_diamond_v2.png")
]
