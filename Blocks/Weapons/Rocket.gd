extends Projectile
class_name Rocket

func on_collision(collision):
	Helper.spawn_aoe(block, position)
	super(collision)
	
func set_variables(_block: Block, _direction):
	super(_block, _direction)
	if direction.dot(Paths.game.player.velocity.normalized()) > 0:
		speed = block.bullet_speed + direction.dot(Paths.game.player.velocity.normalized()) * Paths.game.player.velocity.length()
	else:
		speed = block.bullet_speed
