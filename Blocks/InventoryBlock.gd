extends Control
var stats: BlockStats
@onready var sprite = $Block
@onready var container = $Container
var dragging = false
@onready var ui = Paths.ui_node
var panel_hovered = null
func _ready():
	sprite.modulate = stats.block_class.new().color
	SignalManager.connect("panel_hovered", on_panel_hovered)
	SignalManager.connect("panel_left", on_panel_left)


func on_panel_hovered(panel):
	panel_hovered = panel
func on_panel_left():
	panel_hovered = null
func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			container.mouse_filter = Control.MOUSE_FILTER_IGNORE
			mouse_filter = Control.MOUSE_FILTER_IGNORE
			dragging = true
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if get_parent() is Panel:
				reparent(ui.inventory)
		
func _process(_delta):
	if !dragging:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_viewport().get_mouse_position() - container.size/2
	else:
		dragging = false
		if panel_hovered:
			reparent(panel_hovered)
			position = Vector2(2, 2)
		else:
			if get_parent() is Panel:
				position = Vector2(2, 2)
			else:
				ui.inventory.queue_sort()
		container.mouse_filter = Control.MOUSE_FILTER_PASS
		mouse_filter = Control.MOUSE_FILTER_STOP
