extends Projectile
class_name Orbiter

var rotation_speed

func _physics_process(delta):
	if !block:
		return
	rotation += rotation_speed
	global_position = block.global_position
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() in collided:
			return
		if collision.get_collider() is Enemy:
			collision.get_collider().damage(self)
		add_then_remove_collided(collision.get_collider())
		on_collision(collision)
func add_then_remove_collided(collider):
	collided.append(collider)
	await get_tree().create_timer(0.2).timeout
	collided.remove_at(collided.find(collider))
func on_collision(_collision: KinematicCollision2D):
	particles.reparent(Paths.game.projectiles)
	particles.global_position = _collision.get_position()
	particles.restart()
	
func set_variables(_block: Block, _direction=null):
	block = _block
	rotation_speed = block.rotation_speed
	attack_damage = block.attack_damage
