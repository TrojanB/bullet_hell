extends Node2D
#I KNOW THIS CODE LOOKS LIKE SHIT IM SORY

@export var delay_spawn : int = 1
@onready var spawn_delay = $Spawn_Delay
@onready var spawn_indicator_delay = $Spawn_Indicator_Delay
@onready var level_timer = $Level_Timer
@onready var collected_diamonds := 0

#between these points the enemis will spawn [left top corner, bottom right corner]
#These points are moving with player
@onready var spawn_point_1 : Marker2D
@onready var spawn_point_2 : Marker2D
var player : CharacterBody2D

@onready var enemies_folder = $Enemies
var level_id : int = 0
var game_mode : Gm.game_mode = Gm.game_mode.KILL_AMOUNT
var goal := 15
var label : Label

signal indicator_disapeared
signal level_completed_signal

func _ready():
	print("LEVEL ID: ", level_id)
	spawn_delay.wait_time = delay_spawn
	spawn_point_1 = get_node("Player/Spawn_Area/Spawn_Point_1")
	spawn_point_2 = get_node("Player/Spawn_Area/Spawn_Point_2")
	
	player = get_node("Player")
	
	if player:
		label = player.get_node("UI/Level_Goal")
		if label: 
			label.game_mode = game_mode
			label.goal = goal
			label.start_text()
	match game_mode:
		Gm.game_mode.SURVIVE_TIME:
			level_timer.wait_time = goal + 4 #so when label animation finishes it starts on intended number 
			level_timer.start()

func _process(delta):
	if game_mode == Gm.game_mode.SURVIVE_TIME and player.label_animation_finished:
		send_time()

func send_time():
	var time_left = level_timer.time_left
	var minute = floor(time_left/60)
	var seconds = int(time_left) % 60
	label.update_time([minute,seconds])

func start_spawning():
	spawn_indicator()

func spawn_indicator():
	var enemy_position = create_enemy_pos()
	
	while enemy_position.distance_to(player.global_position) < 30:
		enemy_position = create_enemy_pos()
		
	var spawn_in = Enemies.spawn_indicator.instantiate()
	spawn_in.global_position  = enemy_position
	
	add_child(spawn_in)
	spawn_delay.start()
	spawn_indicator_delay.start()

func create_enemy_pos():
	var spawn_position_x = randf_range(spawn_point_1.global_position.x, spawn_point_2.global_position.x)
	var spawn_position_y = randf_range(spawn_point_1.global_position.y, spawn_point_2.global_position.y)
	var enemy_position = Vector2(spawn_position_x, spawn_position_y) 
	return enemy_position

func _on_spawn_timer_timeout():
	spawn_indicator()

#this funcion is from spawn indicator scene connected via connect(Callable) bla bla bla
func _spawn_enemy(pos):
	var enemy = Enemies.enemies[int(randf_range(0, Enemies.enemies.size()))].instantiate()
	enemy.global_position = pos
	add_child(enemy)

func _on_player_player_died():
		pass

func update_goal_label():
	match game_mode:
		Gm.game_mode.KILL_AMOUNT: 
			player.update_ui(goal)

func _on_enemy_died():
	goal-=1
	update_goal_label()
	if goal <= 0:
		level_completed_signal.emit()


func _on_level_completed_signal():
	var lvl_passed_screen = player.get_node("UI/level_passed")
	if level_id > Gm.last_completed_level:
		Gm.last_completed_level = level_id
		print("LEVELS MENAGER INT: ", Gm.last_completed_level)
	if lvl_passed_screen:
		lvl_passed_screen.visible = true
	get_tree().paused = true


func _on_level_timer_timeout():
	level_completed_signal.emit()
