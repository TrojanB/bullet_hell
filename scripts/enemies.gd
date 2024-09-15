extends Node

var enemies : Array = [
	preload("res://enemies/BaseEnemy/SKELETON.tscn"),
	preload("res://enemies/BaseEnemy/GOBLIN.tscn")
]

@onready var spawn_indicator = preload("res://enemies/Spawn_Indicator/spawn_indicator.tscn")
