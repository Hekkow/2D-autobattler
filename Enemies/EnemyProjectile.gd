extends CharacterBody2D
class_name EnemyProjectile

var speed: float
var direction: Vector2
var attack_damage: float
var block: Enemy
var collided = []
@onready var particles: CPUParticles2D = $ImpactParticles

func _ready():
	$ColorRect.color = block.bullet_color

func _physics_process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() in collided:
			return
		if collision.get_collider() is Block:
			collision.get_collider().damage(self)
		collided.append(collision.get_collider())
		on_collision(collision)
func on_collision(_collision):
	particles.reparent(Paths.game.projectiles)
	particles.restart()
	queue_free()
func set_variables(_block: Enemy, _direction):
	block = _block
	speed = block.bullet_speed
	attack_damage = block.attack_damage
	direction = Helper.dir(_direction)
	rotation = direction.angle()
