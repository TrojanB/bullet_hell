extends RigidBody2D

@onready var diamond_sprite = $Pick_up_area/DiamondSprite
@onready var impulse_ended = $ImpulseEnded
@onready var animation_player = $AnimationPlayer

func _ready():
	apply_texture()
	
	var force1 = randf_range(-100, 100)  # losowa siła wyrzutu
	var force2 = randf_range(-100, 100)  # losowa siła wyrzutu
	apply_central_impulse(Vector2(force1, force2))

func apply_texture():
	var diamond_texture = Gm.diamonds_textures[randf_range(0, Gm.diamonds_textures.size())]
	diamond_sprite.texture = diamond_texture

func _on_impulse_ended_timeout():
	linear_velocity = Vector2.ZERO


func _on_pick_up_area_area_entered(area):
	print(area)


func _on_animation_player_animation_finished(anim_name):
	animation_player.play("idle")
