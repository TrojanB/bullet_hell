extends Control

var weapon : weapon_card = null

@onready var card_panel = $Card_Panel
@onready var roll_down_panel = $Roll_Down_Panel
@onready var animation_player = $AnimationPlayer
@onready var roll_down_bool = false

@onready var name_label = $Card_Panel/Name_Label
@onready var button = $Card_Panel/Button
@onready var damage_label = $Roll_Down_Panel/Damage_Label
@onready var fire_rate_label = $Roll_Down_Panel/Fire_Rate_Label
@onready var level_label = $Card_Panel/Level_Label
@onready var weapon_texture = $Card_Panel/Weapon_Texture
@onready var upgrade_progress = $Roll_Down_Panel/UpgradeProgress
@onready var upgrade_progress_label = $Roll_Down_Panel/UpgradeProgress/UpgradeProgressLabel

@onready var path_to_guns_sprites : String = Gm.path_to_guns_sprites
var is_dragging = false

func _ready():
	update_ui()

func _gui_input(event):
	if event is InputEventScreenTouch and not event.is_pressed() and not is_dragging:
		if roll_down_bool:
			animation_player.play("roll_up")
			roll_down_bool = false
		else:
			animation_player.play("roll_down")
			roll_down_bool = true
	elif event is InputEventScreenDrag and not is_dragging:
		is_dragging = true
	elif InputEventScreenTouch and not event.is_pressed() and is_dragging:
		is_dragging = true

func update_ui():
	if weapon:
		if name_label:
			name_label.text = weapon.weapon_name
		else:
			print("name_label is null")
		
		if level_label:
			level_label.text = "LVL " + str(weapon.level)
		else:
			print("level_label is null")
		
		if damage_label:
			damage_label.text = "DMG: " + str(weapon.damage)
		else:
			print("damage_label is null")
		
		if fire_rate_label:
			fire_rate_label.text = "FR: " + str(weapon.fire_rate)
		else:
			print("fire_rate_label is null")
		
		var weapon_image = load(path_to_guns_sprites + weapon.weapon_name + ".png")
		if weapon_image:
			weapon_texture.texture = weapon_image
		print("WEAPON CARD: ALRIGHT")
		
		if upgrade_progress and upgrade_progress_label:
			var needed_cards = Gm.COMMON_AMOUNTS[weapon.level - 1]
			upgrade_progress.max_value = needed_cards
			upgrade_progress.min_value = 0
			upgrade_progress.value = weapon.amount
			upgrade_progress_label.text = str(weapon.amount, "/", needed_cards)
	else:
		print("WEAPON CARD: NOT GOOD")
