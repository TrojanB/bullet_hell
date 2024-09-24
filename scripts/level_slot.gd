extends Control

@onready var button = $Button
@onready var level_name = $Panel/Level_Name
@onready var description = $Panel/Description
@onready var image = $Panel/Image

@export var level_number : int = 0
@export var map : String = "res://scenes/level.tscn"
@export var goal : int = 20
@export var game_mode : Gm.game_mode = Gm.game_mode.KILL_AMOUNT
@export var can_play := false

# Called when the node enters the scene tree for the first time.
func _ready():
	MOUSE_FILTER_IGNORE
	level_name.text = str(level_number)
	if can_play: 
		match game_mode:
			Gm.game_mode.KILL_AMOUNT:
				description.text = "Kill " + str(goal) + " enemies."
			Gm.game_mode.SURVIVE_TIME:
				description.text = "Survive " + str(goal) + " seconds."
			Gm.game_mode.KILL_AMOUNT_TIME:
				description.text = "Kill " + str(goal) + " enemies before time runs up."
			Gm.game_mode.KILL_BOSS:
				description.text = "Kill the boss."
		modulate = Color(1,1,1)
	else:
		modulate = Color(0.405, 0.405, 0.405)
	


func _on_button_button_up():
	if can_play:
		get_tree().change_scene_to_file(map)
