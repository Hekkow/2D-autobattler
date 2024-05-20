extends Control

@onready var grid = $GridContainer
@onready var start_button: Button = $"Buttons/Start"
@onready var inventory = $Inventory
@onready var store = $Store
@onready var money: Label = $Money
@onready var reroll_button: Button = $"Buttons/Reroll"
var aim_menu_open = false

func _ready():
	Paths.ui_node = self
	initialize_inventory()
	initialize_grid()
	initialize_store()
	start_button.pressed.connect(start_game)
	reroll_button.pressed.connect(reroll_store)
	update_money()
	update_reroll()
func initialize_inventory():
	for block in GameData.inventory:
		var inventory_block = Paths.inventory_block.instantiate()
		inventory_block.stats = block
		inventory.add_child(inventory_block)
func initialize_store():
	for i in 4:
		
		var button = Paths.shop_item.instantiate()
		
		#var block_class = WallBlock
		#var block_class = SwordBlock
		var block_class = Blocks.blocks.pick_random()
		button.get_child(0).stats = BlockStats.new(block_class)
		store.add_child(button)
		button.text = str(block_class.new()) + "\n$" + str(block_class.new().price)
		button.pressed.connect(Callable(buy_block).bind(button, block_class))
func reroll_store():
	if !buy(GameData.reroll_cost):
		return
	for node in store.get_children():
		node.queue_free()
	GameData.money -= GameData.reroll_cost
	GameData.reroll_cost += 2
	update_money()
	update_reroll()
	initialize_store()
func buy_block(button, block_class):
	if !buy(block_class.new().price):
		return
	button.queue_free()
	var block = Paths.inventory_block.instantiate()
	block.stats = BlockStats.new(block_class)
	inventory.add_child(block)
	GameData.money -= block_class.new().price
	update_money()
func buy(price):
	if price <= GameData.money:
		return true
	else:
		printerr("No money")
		return false
func update_reroll():
	reroll_button.text = "Reroll $" + str(GameData.reroll_cost)
func update_money():
	money.text = "$" + str(GameData.money)	

	
func initialize_grid():
	grid.columns = GameData.grid_size
	for x in GameData.grid_size:
		for y in GameData.grid_size:
			var panel = Paths.drag_and_drop.instantiate()
			grid.add_child(panel)
			panel.mouse_entered.connect(Callable(panel_mouse_entered).bind(panel))
			panel.mouse_exited.connect(Callable(panel_mouse_exited).bind(panel))
			if x == (GameData.grid_size-1)/2.0 && y == (GameData.grid_size-1)/2.0:
				panel.get_node("DragAndDrop").self_modulate = Color.RED
			if GameData.grid.has(Vector2(y, x)):
				var block = Paths.inventory_block.instantiate()
				block.stats = GameData.grid[Vector2(y, x)]
				panel.add_child(block)
				block.position = Vector2(2, 2)

func panel_mouse_entered(panel):
	panel.set_meta("original", panel.self_modulate)
	panel.self_modulate = Color.BLACK
	SignalManager.emit_signal("panel_hovered", panel)
func panel_mouse_exited(panel):
	panel.self_modulate = panel.get_meta("original")
	SignalManager.emit_signal("panel_left")
	

func start_game():
	if grid.get_child(GameData.grid_size*(GameData.grid_size/2.0)-0.5).get_child_count() < 2:
		printerr("middle block missing")
		return
	GameData.grid.clear()
	for x in GameData.grid_size:
		for y in GameData.grid_size:
			var index = x*GameData.grid_size+y
			var block = grid.get_child(index)
			if block.get_child_count() > 1:
				GameData.grid[Vector2(y, x)] = block.get_child(1).stats
				if index == GameData.grid_size**2/2.0-0.5:
					GameData.center = Vector2(y, x)
	GameData.inventory.clear()
	for i in inventory.get_children():
		GameData.inventory.append(i.stats)
	SignalManager.emit_signal("start_game_pressed")
	queue_free()
