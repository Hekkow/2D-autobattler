extends Block
class_name WallBlock

func _init():
	price = 20
	color = Color.RED
	collision_damage = 100
	max_health = 200
	health = 200

func _to_string():
	return "Wall"
