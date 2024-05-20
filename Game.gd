extends Node2D

var enemy_spawn_time = 1
var closest_enemy_spawn = 30
var timer
var round_number = 0
var wave = 0
var player
@onready var projectiles = $Projectiles
var spawn_indicator_time = 1
var time_between_enemies = 0.1
var spawning = false
var wave_enemy_time_ratio = 0.15 # time to wait per enemy
var rounds = [
	Round.new([Wave.new(RegularEnemy, 30)], 2, 10),
	Round.new([Wave.new(Charger, 60)], 3, 10),
	Round.new([Wave.new(Villainous, 60)], 4, 10),
	Round.new([Wave.new(RegularEnemy, 20), Wave.new(Charger, 35), Wave.new(Villainous, 30)], 6, 5),
	Round.new([Wave.new(RegularEnemy, 40), Wave.new(Charger, 70), Wave.new(Villainous, 60)], 6, 5),
	Round.new([Wave.new(Boss, 1)], 1, 1)
]

func _ready():
	Paths.game = self
	Paths.projectiles = projectiles
	SignalManager.connect("start_game_pressed", start_game)
	SignalManager.connect("game_over", game_over)
	SignalManager.connect("round_won", round_won)
	timer = Timer.new()
	timer.wait_time = enemy_spawn_time
	timer.timeout.connect(start_wave)
	add_child(timer)

func start_game():
	player = Paths.player.instantiate()
	add_child(player)
	start_enemy_spawner()

func round_won():
	timer.stop()
	round_number += 1
	await get_tree().create_timer(2).timeout
	
	player.queue_free()
	for i in projectiles.get_children():
		i.queue_free()
	if round_number == rounds.size():
		print("GAME WON")
		var game_over_scene = Paths.game_over.instantiate()
		
		add_child(game_over_scene)
		game_over_scene.get_node("Panel").size = get_viewport().size
		game_over_scene.get_node("Panel").position = -get_viewport().size / 2
	else:
		var ui = Paths.ui.instantiate()
		add_child(ui)
		ui.get_node("Panel").size = get_viewport().size
	

func start_enemy_spawner():
	wave = 0
	timer.start()
	spawning = true
	
func game_over():
	timer.stop()
	for i in projectiles.get_children():
		i.queue_free()
	var lost_game_scene = Paths.lost_game.instantiate()
	add_child(lost_game_scene)
	
func start_wave():
	timer.stop()
	var pos = get_spawn_location()
	await spawn_spawn_indicator(pos)
	for i in rounds[round_number].waves[wave]:
		await get_tree().create_timer(time_between_enemies).timeout
		spawn_enemy(pos, i)
		
	if rounds[round_number].waves.size() <= wave + 1:
		spawning = false
		return
	timer.wait_time = rounds[round_number].waves[wave].size() * wave_enemy_time_ratio
	wave += 1
	timer.start()
	

func spawn_enemy(pos, _enemy):
	var enemy = Paths.enemy.instantiate()
	enemy.set_script(_enemy)
	enemy.position = pos + Vector2(randi_range(-1, 1), randi_range(-1, 1))
	add_child(enemy)
	GameData.active_enemies.append(enemy)

func spawn_spawn_indicator(pos):
	var spawn_indicator = Paths.spawn_indicator.instantiate()
	spawn_indicator.position = pos
	projectiles.add_child(spawn_indicator)
	spawn_indicator.get_node("Flash").spawn_indicator()
	await get_tree().create_timer(spawn_indicator_time).timeout
	if spawn_indicator != null:
		spawn_indicator.queue_free()
		
func get_spawn_location():
	while true:
		var pos = Vector2(randi_range(0, $SizeDetection/Control.size.x), randi_range(0, $SizeDetection/Control.size.y))
		var closest_block = Helper.find_closest_pos(pos, GameData.active_blocks)
		if !closest_block:
			return
		if pos.distance_to(closest_block.global_position) > closest_enemy_spawn:
			return pos
