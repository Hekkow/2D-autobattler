extends Projectile
class_name HeatseekingMissile

func _physics_process(delta):
	speed += acceleration
	var closest_enemy = Helper.find_closest(self, GameData.active_enemies)
	if !closest_enemy || global_position.distance_to(closest_enemy.global_position) > block.max_seeking_distance:
		velocity = direction * speed
	else:
		velocity = (closest_enemy.global_position - global_position).normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() in collided:
			return
		if collision.get_collider() is Enemy:
			collision.get_collider().damage(self)
		collided.append(collision.get_collider())
		on_collision(collision)

func on_collision(collision):
	Helper.spawn_aoe(block, position)
	super(collision)
