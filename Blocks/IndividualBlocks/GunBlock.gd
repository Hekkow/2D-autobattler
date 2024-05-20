extends Block
class_name GunBlock

func _init():
	bullet_speed = 600
	attack_damage = 25
	price = 100
	passive_cooldown = 0.2
	color = Color.BLUE
	bullet_color = Color.BLUE
	weapon = Bullet

func activate():
	Helper.spawn_projectile(self)

func _to_string():
	return "Gun"
