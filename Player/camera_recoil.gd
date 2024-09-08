extends Camera2D

@onready var animation_player = $AnimationPlayer
@onready var can_play = true

func on_shoot_signal():
	if can_play:
		animation_player.play("camera_shaking")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "camera_shaking":
		can_play = true
