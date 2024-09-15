extends CharacterBody2D

#enemy properties
@export var speed : float = 50
@export var health :float = 50
@export var attack_damage : float = 20
@export var knockback_force : float = 100
@export var attack_delay : float = 2

#player reference
@onready var player = get_node("/root/level/Player")

@onready var can_attack_timer = $CanAttackTimer #cooldown between attacks
@onready var enemy_sprite = $EnemySprite
@onready var health_bar = $HealthBar
@onready var take_damage_timer = $EnemySprite/take_damage_timer

var direction : Vector2
var can_attack := true
var in_attack_range := false
var can_move := true

signal took_damage

var one : float = 1

func _ready():
	can_attack_timer.wait_time = attack_delay
	health_bar.max_health = int(health)

func _physics_process(delta):
	if player and can_move:
		direction = global_position.direction_to(player.global_position)
		velocity = direction.normalized() * speed
		if player.global_position.x > global_position.x:
			enemy_sprite.flip_h = false
		else:
			enemy_sprite.flip_h = true
	if in_attack_range and can_attack:
		attack_player()
	move_and_slide()

func stop_moving():
	can_move = false
	in_attack_range = true
	velocity = Vector2.ZERO

func start_moving():
	in_attack_range = false
	can_move = true

func attack_player():
	var attack = Attack.new()
	attack.damage = attack_damage
	attack.knockback_force = knockback_force
	attack.attack_position = global_position
	player.enemy_attacked(attack)
	enemy_sprite.play("attack")
	can_attack_timer.start()
	can_attack = false

func take_damage(attack : Attack):
	health -= attack.damage
	if health <= 0:
		can_move = false
		velocity = Vector2.ZERO
		collision_layer = 0
		collision_mask = 0
		enemy_sprite.play("dying")
	var knockback_direction = attack.attack_position.direction_to(self.global_position)
	var knockback = knockback_direction * attack.knockback_force
	global_position += knockback
	
	enemy_sprite.material.set("shader_param/hit_opacity", 1.0) #musze sie tak meczyc zamiast zrobic animacje bo z jakiegos powodu nie znajduje m shader param a kluczyk nic nie robi kiedy klikam lmao
	take_damage_timer.start()
	took_damage.emit(health)

func _on_attack_timer_timeout():
	can_attack = true


func _on_take_damage_timer_timeout():
	enemy_sprite.material.set("shader_param/hit_opacity", 0.0)

func _on_enemy_sprite_animation_finished():
	var finished_animation = enemy_sprite.animation
	
	if finished_animation == "dying":
		queue_free()
	if finished_animation == "attack":
		enemy_sprite.play("walking")
