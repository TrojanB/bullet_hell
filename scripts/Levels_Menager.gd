extends HBoxContainer

@onready var last_completed_level = Gm.last_completed_level
@onready var scroll_container = $".."
var scroll_offset := 76

func _ready():
	for i in range(get_child_count()):
		var level = get_child(i)
		if level.has_method("is_completed"):
			level.level_id = i
			if level.level_id <= last_completed_level:
				level.can_play = true
				level.completed = true
			elif level.level_id == last_completed_level + 1:
				level.can_play = true
				level.completed = false
			else:
				level.can_play = false
				level.completed = false
			level.update_ui()
	scroll_container.set_deferred("scroll_horizontal", last_completed_level * scroll_offset)
