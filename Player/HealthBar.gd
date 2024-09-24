extends TextureProgressBar

@onready var player = $"../.."
var max_health : int

func _ready():
	max_health = player.health
	max_value = max_health
	value = max_health
	min_value = 0

func _on_player_update_healthbar(health):
	value = health
