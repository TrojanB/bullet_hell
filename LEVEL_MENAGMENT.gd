extends Node2D

var enemies : Array = [
	preload("res://enemies/BaseEnemy/SKELETON.tscn"),
	preload("res://enemies/BaseEnemy/GOBLIN.tscn")
]

@export var delay_spawn : int = 1
@onready var spawn_timer = $Spawn_Timer

#between these points the enemis will spawn [left top corner, bottom right corner]
@onready var spawn_point_1 = $Spawn_Area/Spawn_Point_1
@onready var spawn_point_2 = $Spawn_Area/Spawn_Point_2

@onready var enemies_folder = $Enemies

func _ready():
	spawn_timer.wait_time = delay_spawn
	spawn_enemy()

func spawn_enemy():
	var enemy = enemies[int(randf_range(0, enemies.size()))].instantiate()
	var spawn_position_x = randf_range(spawn_point_1.global_position.x, spawn_point_2.global_position.x)
	var spawn_position_y = randf_range(spawn_point_1.global_position.y, spawn_point_2.global_position.y)
	enemies_folder.add_child(enemy)
	enemy.global_position = Vector2(spawn_position_x, spawn_position_y)
	
	spawn_timer.start()


func _on_spawn_timer_timeout():
	spawn_enemy()
