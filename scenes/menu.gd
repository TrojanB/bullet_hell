extends Control

@onready var inventory = $Inventory
@onready var main_screen = $MainScreen
@onready var card_opening = $Card_Opening

var is_dragging := false
var current_tab_index := 1  # 0 = inventory, 1 = menu, 2 = card_opening
var swipe_threshold := 4  # Minimalna odległość potrzebna do wykrycia przesunięcia
var swipe_start_position : Vector2
var tab_positions := [0, -90, -180]  # Pozycje X zakładek

var go_right : bool = false

func  _ready():
	position.x = -90
	set_process_input(true)

func _gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		swipe_start_position = event.position
		
	elif event is InputEventScreenDrag:
		is_dragging = true
		var swipe_delta = event.position - swipe_start_position
		print(swipe_delta.x)
		if swipe_delta.x > swipe_threshold: #zmieniam zakladke w lewo
			position.x += swipe_delta.x
			go_right = false
		elif swipe_delta.x < -swipe_threshold: #zmieniam zakladke w prawo
			position.x += swipe_delta.x
			go_right = true
		
	elif is_dragging and event is InputEventScreenTouch and not event.is_pressed():
		is_dragging = false
		swipe_start_position = Vector2.ZERO
		if go_right and current_tab_index < tab_positions.size()-1:
			current_tab_index+=1
		elif not go_right and current_tab_index > 0:
			current_tab_index -=1
		move_to_tab(current_tab_index)
	elif not is_dragging and event is InputEventScreenTouch and not event.is_pressed():
		pass

# Funkcja do przeskoku do najbliższej zakładki
func snap_to_closest_tab():
	var closest_tab_index = current_tab_index
	var min_distance = abs(position.x - tab_positions[current_tab_index])

	# Znajdź najbliższą zakładkę
	for i in range(tab_positions.size()):
		var distance = abs(position.x - tab_positions[i])
		if distance < min_distance:
			min_distance = distance
			closest_tab_index = i
	
	current_tab_index = closest_tab_index
	move_to_tab(current_tab_index)

# Przemieszcza pozycję do odpowiedniej zakładki
func move_to_tab(tab_index):
	var target_x = tab_positions[tab_index]
	var tween = get_tree().create_tween()
	tween.EASE_OUT
	tween.tween_property(self, "position", Vector2(target_x,position.y), 0.12)
