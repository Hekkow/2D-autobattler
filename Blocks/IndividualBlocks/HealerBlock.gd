extends Block
class_name HealerBlock

func _init():
	price = 150
	passive_cooldown = 3
	color = Color.GREEN
	aoe_time = 1
	aoe_color = Color.GREEN_YELLOW
	aoe_size = 3
	aoe_weapon = Heal

func activate():
	Helper.spawn_aoe(self, global_position)

func _to_string():
	return "Healer"
