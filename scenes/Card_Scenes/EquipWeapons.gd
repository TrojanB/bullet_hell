extends HBoxContainer

func _ready():
	for slot in get_children():
		slot.connect("slot_pressed", Callable(self, "on_slot_pressed").bind(slot))

func on_slot_pressed(slot):
	
