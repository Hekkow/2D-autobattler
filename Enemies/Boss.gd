extends Enemy
class_name Boss
var size_scale = 3
var spawn_speed = 0.20
var enemies = [Villainous, RegularEnemy, Charger]
var spawn_range = 50
func _init():
	health = 50000
	speed = 5000
	attack_damage = 200
	original_color = Color.WHITE

func _physics_process(_delta):
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	apply_force((target.global_position - global_position).normalized() * speed)
func _ready():
	
	var timer = Timer.new()
	timer.wait_time = spawn_speed
	timer.timeout.connect(spawn)
	add_child(timer)
	
	mass = 100
	get_node("CollisionShape2D").shape.size *= size_scale
	
	get_node("Enemy").scale *= size_scale
	super()
	await get_tree().create_timer(0.5).timeout
	timer.start()
func spawn():
	get_parent().spawn_enemy(global_position + Vector2(randf_range(-spawn_range, spawn_range), randf_range(-spawn_range, spawn_range)), enemies.pick_random())
