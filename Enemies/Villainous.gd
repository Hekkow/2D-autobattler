extends Enemy
class_name Villainous
var bullet_speed = 300
var bullet_color = Color.RED
var attack_speed = 1
func _init():
	attack_damage = 25
	original_color = Color.PURPLE
func _ready():
	var timer = Timer.new()
	timer.wait_time = attack_speed
	timer.timeout.connect(shoot)
	add_child(timer)
	timer.start()
	super()
func shoot():
	var bullet = Paths.enemy_projectile.instantiate()
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	var direction = (target.global_position - global_position).normalized()
	bullet.set_variables(self, direction)
	Paths.projectiles.add_child(bullet)
	bullet.position = global_position
func _physics_process(_delta):
	var target = Helper.find_closest(self, GameData.active_blocks)
	if !target:
		return
	apply_force(-(target.global_position - global_position).normalized() * speed)
	
