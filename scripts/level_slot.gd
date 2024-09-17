extends Control

@onready var panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	panel.MOUSE_FILTER_IGNORE
