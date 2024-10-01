extends Control

@onready var button = $Button
@onready var level_name = $Panel/Level_Name
@onready var description = $Panel/Description
@onready var image = $Panel/Image

@export var level_id : int = 0
@export var maps : Array[PackedScene] = [
	preload("res://scenes/Levels_scenes/level.tscn")
]
@export var goal : int = 20
@export var game_mode : Gm.game_mode = Gm.game_mode.KILL_AMOUNT
@export var can_play := true
@export var completed := true

# Called when the node enters the scene tree for the first time.
func _ready():
	MOUSE_FILTER_IGNORE
	level_name.text = str(level_id)
	update_ui()


func _on_button_button_up():
	if can_play:
		var map = create_level()
		print(map)
		if map:
			get_tree().current_scene.queue_free()
			get_tree().root.add_child(map)
			get_tree().current_scene = map

func create_level():
	var map = maps[0].instantiate()
	if map:
		map.level_id = level_id
		map.goal = goal
		map.game_mode = game_mode
		return map
	else: 
		return false

func is_completed():
	return completed

func change_can_play(value : bool):
	can_play = value
	
func update_ui():
	level_name.text = str(level_id)
	if can_play or completed: 
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
		if completed:
			level_name.self_modulate = Color(0.37, 0.797, 0.036)
	else:
		modulate = Color(0.405, 0.405, 0.405)
