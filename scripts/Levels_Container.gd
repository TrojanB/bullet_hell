extends HBoxContainer


func _ready():
	for i in range(get_child_count()):
		var level = get_child(i)
		if level.has_method("is_completed") and level.is_completed():
			print(level.is_completed())
			var next_level = get_child(i+1)
			next_level.change_can_play(true)
			next_level.update_ui()

