extends Block
class_name PierceBlock

func _init():
	bullet_speed = 1500
	attack_damage = 200
	price = 60
	passive_cooldown = 2
	color = Color.MEDIUM_PURPLE
	bullet_color = Color.MEDIUM_PURPLE
	weapon = Pierce

func activate():
	Helper.spawn_projectile(self)

func _to_string():
	return "Pierce"
