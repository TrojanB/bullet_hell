extends Sprite2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.connect("animation_finished", Callable(get_parent(), "_spawn_enemy").bind(global_position))

func _on_animation_player_animation_finished(anim_name):
	var level = get_parent()
	level._spawn_enemy(global_position)
	queue_free()
