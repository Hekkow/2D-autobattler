extends Area2D
class_name AOE
var attack_damage
var block
var original_color
var aoe_time
@onready var sprite = $Sprite2D
@onready var flash = $Flash
func _ready():
	sprite.modulate = block.aoe_color
	original_color = block.aoe_color
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = block.aoe_time
	timer.timeout.connect(expire)
	add_child(timer)
	timer.start()
	body_entered.connect(explode)
	flash.explosion()
	
func expire():
	queue_free()
	
func explode(body):
	if body is Enemy:
		body.apply_impulse(-body.linear_velocity)
		body.apply_impulse((body.global_position - global_position).normalized() * block.aoe_knockback)
		body.damage(self)
	
func set_variables(_block: Block):
	block = _block
	attack_damage = _block.aoe_damage
	aoe_time = block.aoe_time
