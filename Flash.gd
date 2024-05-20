extends Node

var tween
@onready var obj = get_parent()
func flash_white():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	obj.sprite.modulate = Color.WHITE
	tween.tween_property(obj.sprite, "modulate", obj.original_color, 0.2)
func explosion():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	var transparent = obj.original_color
	transparent.a = 0
	obj.sprite.modulate = transparent
	tween.tween_property(obj.sprite, "modulate", obj.original_color, obj.aoe_time/8.0)
	tween.tween_property(obj.sprite, "modulate", transparent, obj.aoe_time/8.0*7)
func spawn_indicator():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	var transparent = obj.modulate
	transparent.a = 0
	obj.modulate = transparent
	tween.tween_property(obj, "modulate", Color.PINK, Paths.game.spawn_indicator_time/8.0*6)
	tween.tween_property(obj, "modulate", transparent, Paths.game.spawn_indicator_time/8.0*2)
func heal():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	var transparent = obj.modulate
	transparent.a = 0
	obj.modulate = transparent
	tween.tween_property(obj, "modulate", Color.GREEN, Paths.game.spawn_indicator_time/8.0*6)
	tween.tween_property(obj, "modulate", transparent, Paths.game.spawn_indicator_time/8.0*2)
func boss_flash():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	obj.sprite.modulate = Color.RED
	tween.tween_property(obj.sprite.modulate, "modulate", obj.original_color, 0.15)
func _exit_tree():
	if tween:
		tween.kill()
