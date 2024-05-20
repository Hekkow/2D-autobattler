extends Projectile
class_name BouncyBullet
var max_bounces = 3
var current_bounces = 0
func on_collision(collision: KinematicCollision2D):
	particles.global_position = global_position
	particles.reparent(Paths.game.projectiles)
	particles.restart()
	current_bounces += 1
	direction = velocity.bounce(collision.get_normal()).normalized()
	if current_bounces == max_bounces:
		queue_free()
func _physics_process(delta):
	speed += acceleration
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() is Enemy:
			collision.get_collider().damage(self)
		on_collision(collision)
