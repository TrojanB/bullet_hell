extends Sprite2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.connect("animation_finished", Callable(get_parent(), "_spawn_indicator_finished"))

func _on_animation_player_animation_finished(anim_name):
	print(get_parent())
	queue_free()
