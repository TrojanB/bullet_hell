extends CharacterBody2D

@export var speed :float = 100
@export var health : float = 100
var character_direction : Vector2

@onready var player_model = $PlayerModel
@onready var pistol = $Weapons/Pistol
@onready var health_bar = $HealthBar

signal update_healthbar
signal player_died

func _ready():
	$GAME_OVER.visible = false


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
	update_healthbar.emit(health)
	var knockback_direction = attack.attack_position.direction_to(global_position)
	var knockback = knockback_direction * attack.knockback_force
	global_position += knockback
	if health <= 0:
		player_died.emit()

func _on_player_hit_area_body_entered(body):
	if body.has_method("stop_moving"):
		body.stop_moving()

func _on_player_hit_area_body_exited(body):
	if body.has_method("start_moving"):
		body.start_moving()


func _on_player_died():
	$GAME_OVER.visible = true
	$Camera2D/AnimationPlayer.play("RESET")
	get_tree().paused = true
