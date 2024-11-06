extends Control
@onready var animation_player = $TextureRect/AnimationPlayer
@export var taps_to_open := 10
var debounce = false
signal PACK_OPENED


func _gui_input(event):
	if (taps_to_open > 0) and (event is InputEventScreenTouch and event.is_pressed() or event is InputEventMouseButton and event.is_pressed()):
		taps_to_open -= 1
		animation_player.play("tapped")
	elif (taps_to_open <= 0) and (event is InputEventScreenTouch and event.is_pressed() or event is InputEventMouseButton and event.is_pressed()):
		if not debounce:
			debounce = true
			animation_player.play("open")
			PACK_OPENED.emit()
