extends Node2D

@export var delay_spawn : int = 1
@onready var spawn_delay = $Spawn_Delay
@onready var spawn_indicator_delay = $Spawn_Indicator_Delay

#between these points the enemis will spawn [left top corner, bottom right corner]
#These points are moving with player
@onready var spawn_point_1 : Marker2D
@onready var spawn_point_2 : Marker2D
var player : CharacterBody2D

@onready var enemies_folder = $Enemies
var game_mode : Gm.game_mode

signal indicator_disapeared

func _ready():
	spawn_delay.wait_time = delay_spawn
	spawn_point_1 = get_node("Player/Spawn_Area/Spawn_Point_1")
	spawn_point_2 = get_node("Player/Spawn_Area/Spawn_Point_2")
	
	player = get_node("Player")
	
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
