extends TextureProgressBar

@onready var max_health : int
@onready var enemy = $".."


func _ready():
	max_health = enemy.health
	max_value = max_health
	min_value = 0
	value = max_health


func _on_enemy_took_damage(health):
	value = int(health)
