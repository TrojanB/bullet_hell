extends Control

@onready var button = $Button
@onready var level_name = $Panel/Level_Name
@onready var description = $Panel/Description
@onready var image = $Panel/Image

@export var map : PackedScene = preload("res://scenes/level.tscn")
@export var goal : int = 20
@export var game_mode : Gm.game_mode = Gm.game_mode.KILL_AMOUNT

# Called when the node enters the scene tree for the first time.
func _ready():
	MOUSE_FILTER_IGNORE
	match game_mode:
		Gm.game_mode.KILL_AMOUNT:
			description.text = "Kill " + str(goal) + " enemies."
		Gm.game_mode.SURVIVE_TIME:
			description.text = "Survive " + str(goal) + " seconds."
		Gm.game_mode.KILL_AMOUNT_TIME:
			description.text = "Kill " + str(goal) + " enemies before time runs up."
		Gm.game_mode.KILL_BOSS:
			description.text = "Kill the boss."


func _on_button_button_up():
	print("LEVEL CLICKED")
