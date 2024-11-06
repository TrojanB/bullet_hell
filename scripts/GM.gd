extends Node
#MAIN VARIABLES
var last_completed_level : int = 10
var diamonds : int = 0
var player_weapon_cards : Array[weapon_card]

enum game_mode {KILL_AMOUNT,SURVIVE_TIME,KILL_AMOUNT_TIME,KILL_BOSS}
enum rarities {COMMON, RARE, EPIC, LEGENDARY}
const COMMON_AMOUNTS = [2, 5, 10, 25, 50]
const RARE_AMOUNTS = [2, 5, 10, 25, 50]
const EPIC_AMOUNTS = [2, 3, 5]
const LEGENDARY_AMOUNTS = [2, 3, 5]

const path_to_guns_sprites : String = "res://GunsSprites/"
const path_to_guns_scenes : String = "res://Weapons/BASIC_WEAPONS/"

func get_needed_card_amount(rarity : rarities, level : int):
	var amount := 0
	match rarity:
		rarities.COMMON:
			amount = COMMON_AMOUNTS[level + 1]
#DIAMONDS VARIABLES ===============================================
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
