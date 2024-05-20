extends Block
class_name RocketLauncherBlock

func _init():
	aoe_size = 4
	aoe_damage = 200
	bullet_speed = 0
	bullet_acceleration = 10
	attack_damage = 20
	price = 100
	passive_cooldown = 1
	color = Color(0.61377304792404, 0.88351052999496, 0.91523617506027)
	bullet_color = Color(0.61377304792404, 0.88351052999496, 0.91523617506027)
	aoe_color = Color(0.61377304792404, 0.88351052999496, 0.91523617506027)
	aoe_knockback = 200
	aoe_time = 0.5
	aoe_weapon = AOE
	weapon = Rocket

func activate():
	Helper.spawn_projectile(self)

func _to_string():
	return "Rocket\nLauncher"
