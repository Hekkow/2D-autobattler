class_name Block
extends StaticBody2D

var color: Color = Color.BLACK

var passive_cooldown = 1
var auto_aim = true
var health = 100
var max_health = 100
var price: int
var attack_damage: int
var bullet_speed: int
var bullet_acceleration = 0
var bullets_per_shot: int
var bullet_color: Color
var collision_damage = 35
var weapon
var aoe_size
var aoe_damage
var aoe_color
var aoe_time
var aoe_knockback
var aoe_weapon
var timer
var coords: Vector2
var flash_tween

@onready var sprite = $Block
@onready var particles = $DeathParticles
@onready var flash = $Flash
var original_color

func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.wait_time = passive_cooldown
	timer.timeout.connect(activate)
	add_child(timer)
	sprite.modulate = color
	particles.color = color
	original_color = color
	SignalManager.connect("round_won", destroy_if_orphan)
func destroy_if_orphan():
	if !is_inside_tree():
		queue_free()
func _init():
	pass

func activate():
	pass

func damage(thing):
	health -= thing.attack_damage
	if health <= 0:
		die()
	else:
		flash.flash_white()


func die():
	particles.reparent(Paths.game.projectiles)
	particles.restart()
	GameData.active_blocks.remove_at(GameData.active_blocks.find(self))
	GameData.grid.erase(coords)
	get_parent().collision_shapes[coords].queue_free()
	get_parent().collision_shapes.erase(coords)
	if GameData.active_blocks.size() == 0 or GameData.center == coords:
		print("GAME OVER")
		SignalManager.emit_signal("game_over")
	get_parent().remove_child(self)
	
