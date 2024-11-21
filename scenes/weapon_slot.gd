extends Control

signal slot_pressed
var debounce := false

func _ready():
	set_process_input(true)

func _gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		if not debounce:
			slot_pressed.emit()
			debounce = true
	elif InputEventScreenTouch and not event.is_pressed() and debounce:
		debounce = false
