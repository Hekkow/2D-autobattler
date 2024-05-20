extends Enemy
class_name Charger

var charge_max_distance = 300
var charge_up_time = 1
var charge_strength = 1000
var post_charge_time = 2

func _init():
	original_color = Color.RED

func _physics_process(_delta):
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	apply_force((target.global_position - global_position).normalized() * speed)
	if target.global_position.distance_to(global_position) <= charge_max_distance:
		charge()
func charge():
	set_physics_process(false)
	apply_impulse(-linear_velocity)
	await get_tree().create_timer(charge_up_time).timeout
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	apply_impulse((target.global_position - global_position).normalized() * charge_strength)
	await get_tree().create_timer(post_charge_time).timeout
	set_physics_process(true)

