extends CharacterBody2D

var speed = 130
var block_spacing = 14

var collision_shapes = {}

func _ready():
	spawn_blocks()
	SignalManager.connect("game_over", game_over)
func game_over():
	queue_free()
func _exit_tree():
	GameData.active_blocks.clear()
func spawn_blocks():
	for coords in GameData.grid:
		var block = Paths.block.instantiate()
		block.set_script(GameData.grid[coords].block_class)
		block.coords = coords
		add_child(block)
		block.position = (coords - GameData.center) * block_spacing
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = block.get_node("CollisionShape2D").shape
		collision_shape.global_position = block.get_node("CollisionShape2D").global_position
		add_child(collision_shape)
		collision_shapes[coords] = collision_shape
		GameData.active_blocks.append(block)
	position = Vector2(100, 100)
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * speed
	rotation = (get_viewport().get_mouse_position() - position).angle()+deg_to_rad(90)
	move_and_slide()
	
