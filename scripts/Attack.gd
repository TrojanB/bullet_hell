extends Node
class_name Attack

var damage : float = 0
var knockback_force : float = 0
var attack_position : Vector2

func create(_damage : float, _knockback_force : float, _attack_position : Vector2):
	damage = _damage
	knockback_force = _knockback_force
	attack_position = _attack_position
