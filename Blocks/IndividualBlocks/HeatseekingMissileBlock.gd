extends Block
class_name HeatseekingMissileBlock
var deviation = 10
var max_seeking_distance = 150

func _init():
	bullet_speed = 50
	bullet_acceleration = 5
	attack_damage = 10
	bullets_per_shot = 5
	price = 80
	passive_cooldown = 1
	aoe_color = Color(0.85526347160339, 0.16821783781052, 0.42279645800591)
	aoe_time = 0.1
	aoe_knockback = 50
	aoe_damage = 10
	aoe_size = 2
	aoe_weapon = AOE
	color = Color.BURLYWOOD
	weapon = HeatseekingMissile
	bullet_color = Color.BURLYWOOD

func activate():
	for i in bullets_per_shot:
		Helper.spawn_projectile(self, (i-floor(bullets_per_shot/2.0)) * deviation)

func _to_string():
	return "Heatseeking\nMissiles"
