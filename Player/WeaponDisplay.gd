extends Node2D

@onready var weapons : Array = []
@onready var camera_2d = $"../Camera2D"
var weapon_pivot_rotation : float = 0



func _ready():
	for weapon in get_children():
		if weapon.has_method("shoot"):
			weapons.append(weapon)
			weapon.weapon_pivot_rotation = weapon_pivot_rotation
			var weapon_pivot = weapon.get_node("WeaponPivot")
			weapon_pivot.rotation = deg_to_rad(weapon_pivot_rotation)
			weapon_pivot_rotation += 15


