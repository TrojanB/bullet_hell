class_name weapon_card
#Weapon variables
var weapon_name : String = "{Undefined}"
var damage : float = 1
var fire_rate : float = 1
var radius : float = 1
#Card Variables
var amount : int = 1
var rarity : Gm.rarities
var level : int = 1

func _init(_weapon_name : String = "{Undefined}", _damage : float = 1, _fire_rate : float = 1, _radius : float = 1, _amount : int = 1, _rarity : Gm.rarities = Gm.rarities.COMMON, _level : int = 1):
	weapon_name = _weapon_name
	damage = _damage
	fire_rate = _fire_rate
	radius = _radius
	amount = _amount
	rarity = _rarity
	level = _level
