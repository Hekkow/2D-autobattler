extends RigidBody2D
class_name Enemy
var speed = 150
var enemy_collision_force = 50
var block_collision_force = 300
var health = 100
var attack_damage = 50
var money_per_enemy = 30
var original_color
var can_get_damaged = true
@onready var sprite = $Enemy
@onready var particles = $DeathParticles
@onready var impact_particles = $ImpactParticles
@onready var flash = $Flash
func _ready():
	body_entered.connect(collision)
	SignalManager.connect("game_over", game_over)
	particles.color = original_color
	sprite.modulate = original_color
	
func game_over():
	set_physics_process(false)
func damage(thing):
	if thing is Block:
		health -= thing.collision_damage
	else:
		health -= thing.attack_damage
	if health <= 0:
		particles.reparent(Paths.game.projectiles)
		particles.restart()
		queue_free()
	else:
		if self is Boss:
			flash.boss_flash()
		else:
			flash.flash_white()
		
func _exit_tree():
	GameData.money += money_per_enemy
	GameData.active_enemies.remove_at(GameData.active_enemies.find(self))
	if GameData.active_enemies.size() == 0 && !Paths.game.spawning:
		SignalManager.emit_signal("round_won")
		print("ROUND WON")

func collision(body):
	if body is Enemy && not body is Boss:
		body.apply_impulse((body.global_position - global_position).normalized() * enemy_collision_force)
	elif body is Block:
		damage(body)
		body.damage(self)
		apply_impulse((global_position - body.global_position).normalized() * block_collision_force)
		impact_particles.reparent(Paths.game.projectiles)
		impact_particles.position = (body.global_position - global_position) / 2 + global_position
		impact_particles.restart()
		
