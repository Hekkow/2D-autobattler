extends Block
class_name BouncyMinigunBlock

var deviation = 20

func _init():
	bullet_speed = 600
	attack_damage = 5
	price = 150
	passive_cooldown = 0.1
	color = Color.PINK
	bullet_color = Color.PINK
	weapon = BouncyBullet

func activate():
	Helper.spawn_projectile(self, randf_range(-deviation, deviation))

func _to_string():
	return "Minigun"
