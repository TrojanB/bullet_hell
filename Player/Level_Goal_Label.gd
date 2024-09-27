extends Label

@onready var player = $"../.."
var game_mode : Gm.game_mode = Gm.game_mode.KILL_AMOUNT
var goal : int = 10

@onready var animation_player = $AnimationPlayer
var low_time_animation_playing := false

func _ready():
	match game_mode:
		Gm.game_mode.KILL_AMOUNT:
			text = "ENEMIES LEFT:"
		Gm.game_mode.SURVIVE_TIME:
			text = "TIME LEFT:"
		Gm.game_mode.KILL_AMOUNT_TIME:
			text = "ENEMIES LEFT:"
		Gm.game_mode.KILL_BOSS:
			text = "KILL THE BOSS"

func update_time(time : Array):
	text = "%02d:%02d" % time
	if time[0] == 0 and time[1] < 15 and not low_time_animation_playing:
		animation_player.play("changin_colors")
		low_time_animation_playing = true

func start_text():
	match game_mode:
		Gm.game_mode.KILL_AMOUNT:
			text = "ENEMIES LEFT:"
		Gm.game_mode.SURVIVE_TIME:
			text = "TIME LEFT:"
		Gm.game_mode.KILL_AMOUNT_TIME:
			text = "ENEMIES LEFT:"
		Gm.game_mode.KILL_BOSS:
			text = "KILL THE BOSS"
	animation_player.play("typing_effect")

func _on_animation_player_animation_finished(anim_name):
	visible_ratio = 1
	text = str(goal)
