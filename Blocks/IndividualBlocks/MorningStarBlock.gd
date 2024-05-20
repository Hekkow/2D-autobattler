extends Block
class_name MorningStarBlock

var angle = 0
var rotation_speed = 0.1

func _init():
	attack_damage = 100
	price = 50
	passive_cooldown = 10000
	color = Color(0.41568627953529, 0.13725490868092, 0.20784313976765)
	weapon = Orbiter
	bullet_color = Color(0.41568627953529, 0.13725490868092, 0.20784313976765)
	
func _ready():
	sprite.modulate = color
	particles.color = color
	original_color = color
	var bullet = Paths.orbiter.instantiate()
	bullet.set_variables(self)
	Paths.projectiles.add_child(bullet)
	bullet.position = global_position
	

func _to_string():
	return "Morningstar"
