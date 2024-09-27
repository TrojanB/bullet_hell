extends Button

@export var scene : PackedScene

func _ready():
	connect("button_up", Callable(self, "_on_button_up"))

func _on_button_up():
	if scene:
		get_tree().change_scene_to_packed(scene)
