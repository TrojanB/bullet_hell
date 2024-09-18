extends Label

var game_mode : Gm.game_mode = Gm.game_mode.SURVIVE_TIME
var goal : int = 10

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


func _on_animation_player_animation_finished(anim_name):
	visible_ratio = 1
	text = str(goal)
