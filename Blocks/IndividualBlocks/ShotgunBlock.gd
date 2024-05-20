extends Block
class_name ShotgunBlock


var deviation = 8
func _init():
	bullets_per_shot = 8
	bullet_speed = 800
	attack_damage = 30
	price = 70
	passive_cooldown = 1
	color = Color.BLACK
	bullet_color = Color.BLACK
	weapon = Bullet

func activate():
	for i in bullets_per_shot:
		Helper.spawn_projectile(self, (i-floor(bullets_per_shot/2.0)) * deviation)

func _to_string():
	return "Shotgun"
