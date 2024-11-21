extends Control

var weapon : weapon_card = null
var equipped := false
@onready var roll_down_bool = true

@onready var card_panel = $Card_Panel
@onready var roll_down_panel = $Roll_Down_Panel
@onready var animation_player = $AnimationPlayer

@onready var name_label = $Card_Panel/Name_Label
@onready var equip_button = $Card_Panel/EquipButton
@onready var upgrade_button = $Roll_Down_Panel/UpgradeButton
@onready var damage_label = $Roll_Down_Panel/Damage_Label
@onready var fire_rate_label = $Roll_Down_Panel/Fire_Rate_Label
@onready var level_label = $Card_Panel/Level_Label
@onready var weapon_texture = $Card_Panel/Weapon_Texture
@onready var upgrade_progress = $Roll_Down_Panel/UpgradeProgress
@onready var upgrade_progress_label = $Roll_Down_Panel/UpgradeProgress/UpgradeProgressLabel

@onready var path_to_guns_sprites : String = Gm.path_to_guns_sprites
var is_dragging = false
signal pressed
signal equip
signal upgrade

func _ready():
	update_ui()
	connect("equip", Callable(self, "_on_equipped_changed"))

func _gui_input(event):
	if event is InputEventScreenTouch and not event.is_pressed() and not is_dragging:
		pressed.emit()
		if roll_down_bool:
			roll_down()
		else:
			roll_up()
	elif event is InputEventScreenDrag and not is_dragging:
		print("CARD DRAGGED")
		is_dragging = true
	elif InputEventScreenTouch and event.is_pressed() and is_dragging:
		print("CARD STOPPED")
		is_dragging = false

func update_ui():
	if weapon:
		if name_label:
			name_label.text = weapon.name
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
		
		var weapon_image = load(path_to_guns_sprites + weapon.name + ".png")
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

func roll_down():
	animation_player.play("roll_down")
	roll_down_bool = false

func roll_up():
	animation_player.play("roll_up")
	roll_down_bool = true

func reset():
	animation_player.play("RESET")
	roll_down_bool = true

func _on_equipped_changed():
	if equipped:
		equip_button.text = "UNEQUIP"
	else:
		equip_button.text = "EQUIP"

#===================================================#
func _on_mouse_entered():
	scale = Vector2(1.1,1.1)

func _on_mouse_exited():
	scale = Vector2(1,1)

func _on_upgrade_button_mouse_entered():
	scale = Vector2(1.1,1.1)

func _on_upgrade_button_mouse_exited():
	scale = Vector2(1,1)

func _on_equip_button_mouse_entered():
	scale = Vector2(1.1,1.1)

func _on_equip_button_mouse_exited():
	scale = Vector2(1,1)

func _on_equip_button_button_up():
	equip.emit()
