extends Enemy
class_name RegularEnemy

func _init():
	original_color = Color.BLUE

func _physics_process(_delta):
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	apply_force((target.global_position - global_position).normalized() * speed)
