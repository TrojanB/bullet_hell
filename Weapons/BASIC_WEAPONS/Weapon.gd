extends Area2D

@export var fire_rate := 0.1
@export var damage : float = 15
@export var knockback_force : float = 1

@export var recoil_factor := 5

var can_shoot := true
var flip_sprite := false
var bullet_scene := preload("res://Bullets/light_bullet.tscn")
@export var weapon_pivot_rotation := 0

@onready var timer = $FireRateTimer
@onready var shooting_point = $WeaponPivot/Sprite2D/ShootingPoint #point in gun where bullets spawns
@onready var weapon_pivot = $WeaponPivot
@onready var weapon_sprite = $WeaponPivot/Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var recoil_animation = animation_player.get_animation("Recoil")

signal shoot_signal

@onready var camera = $"../../Camera2D"

func _ready():
	timer.wait_time = fire_rate
	connect("shoot_signal", Callable(camera, "on_shoot_signal"))

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target = enemies_in_range[0]
		
		
		if can_shoot:
			shoot()
			animation_player.play("Recoil")
		
		weapon_pivot.look_at(target.global_position)
		weapon_pivot.rotation += deg_to_rad(weapon_pivot_rotation) #So the guns wont overlap each other
		weapon_sprite.look_at(target.global_position) #So the guns still aim at the target
		
		if weapon_pivot.rotation > deg_to_rad(90) and weapon_pivot.rotation < deg_to_rad(270):
			weapon_sprite.flip_v = true
		else:
			weapon_sprite.flip_v = false

func shoot():
	can_shoot = false
	timer.start()
	
	var bullet := bullet_scene.instantiate()
	bullet.global_position = shooting_point.global_position
	bullet.global_rotation = shooting_point.global_rotation
	
	var attack := Attack.new()
	attack.create(damage, knockback_force, global_position)
	bullet.attack = attack
	
	shooting_point.add_child(bullet)
	shoot_signal.emit()

func _on_timer_timeout():
	can_shoot = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Recoil":
		animation_player.play("idle")
