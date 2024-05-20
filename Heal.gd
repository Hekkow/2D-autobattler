extends Area2D
class_name Heal
var block
var original_color
var aoe_time
var heal_amount
@onready var sprite = $Sprite2D
@onready var flash = $Flash
var healed = []
func _ready():
	set_collision_layer_value(3, false)
	set_collision_mask_value(4, false)
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	sprite.modulate = block.aoe_color
	original_color = block.aoe_color
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = block.aoe_time
	timer.timeout.connect(expire)
	add_child(timer)
	timer.start()
	body_entered.connect(heal)
	flash.heal()
	
func expire():
	queue_free()
	
func heal(body):
	print(body)
	if body is Block && body not in healed:
		print(body.health)
		body.health = body.max_health
		healed.append(body)
		print(body.health)

func _process(_delta):
	global_position = block.global_position

func set_variables(_block: Block):
	block = _block
	aoe_time = block.aoe_time
