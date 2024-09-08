extends CharacterBody2D

@export var speed := 100
@export var health := 100
var character_direction : Vector2

@onready var player_model = $PlayerModel
@onready var pistol = $Weapons/Pistol
@onready var health_bar = $HealthBar

signal take_damage

func _physics_process(delta):
	character_direction.x = Input.get_axis("walk_left", "walk_right")
	character_direction.y = Input.get_axis("walk_up", "walk_down")
	character_direction = character_direction.normalized()
	
	if character_direction.x > 0: 
		player_model.flip_h = false
	elif character_direction.x < 0 : 
		player_model.flip_h = true
	if character_direction:
		velocity = character_direction * speed
		if player_model.animation != "Walk" : player_model.play("Walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		if player_model.animation != "Idle" : player_model.play("Idle")
	move_and_slide()



func enemy_attacked(attack: Attack):
	health -= attack.damage
	take_damage.emit(health)
	velocity = (attack.attack_position - global_position).normalized() * attack.knockback_force
	print(health)


func _on_player_hit_area_body_entered(body):
	if body.has_method("stop_moving"):
		body.stop_moving()

func _on_player_hit_area_body_exited(body):
	if body.has_method("start_moving"):
		body.start_moving()
