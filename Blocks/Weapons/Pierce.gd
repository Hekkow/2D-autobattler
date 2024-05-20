extends Projectile
class_name Pierce


func on_collision(collision):
	particles.global_position = global_position
	particles.reparent(Paths.game.projectiles)
	particles.restart()
	add_collision_exception_with(collision.get_collider())
	if collision.get_collider() is Wall:
		queue_free()
