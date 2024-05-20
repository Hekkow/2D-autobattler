extends Node

func get_neighboring(arr, coords):
	var neighbor_directions = [[0, 1], [0, -1], [-1, 0], [1, 0]]
	var neighbors = []
	for i in neighbor_directions:
		if arr[coords.x + i[0]][coords.y + i[1]]:
			neighbors.append(arr[coords.x + i[0]][coords.y + i[1]])
	return neighbors

func get_file_names(path: String) -> Array:
	var directory = DirAccess.open(path)
	var paths = []
	if directory:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			paths.append(file_name)
			file_name = directory.get_next()
	return paths

func spawn_projectile(block: Block, deviation = 0):
	var bullet = Paths.projectile.instantiate()
	var direction = get_projectile_direction(block, deviation)
	if !direction:
		return
	bullet.set_script(block.weapon)
	bullet.set_variables(block, direction)
	Paths.projectiles.add_child(bullet)
	bullet.position = block.global_position
	bullet.z_index = -1
func get_projectile_direction(block: Block, deviation = 0):
	var direction
	var target = find_closest(block, GameData.active_enemies)
	if !target:
		return
	direction = target.global_position - block.global_position
	direction = direction.normalized().angle() + deg_to_rad(deviation)
	return direction
func spawn_aoe(block: Block, _pos):
	var pos
	if _pos:
		pos = _pos
	else:
		var target = find_closest(block, GameData.active_enemies)
		if !target:
			return
		pos = target.global_position
	var aoe = Paths.aoe.instantiate()
	aoe.set_script(block.aoe_weapon)
	aoe.set_variables(block)
	Paths.projectiles.add_child(aoe)
	aoe.position = pos
	aoe.get_node("CollisionShape2D").shape.radius *= block.aoe_size
	aoe.get_node("Sprite2D").scale *= block.aoe_size
	
func find_closest(obj, arr):
	if len(arr) == 0:
		return
	var closest_thing = arr[0]
	for thing in arr:
		if thing.global_position.distance_squared_to(obj.global_position) < closest_thing.global_position.distance_squared_to(obj.global_position):
			closest_thing = thing
	return closest_thing
func find_closest_pos(pos, arr):
	if len(arr) == 0:
		return
	var closest_thing = arr[0]
	for thing in arr:
		if thing.global_position.distance_squared_to(pos) < closest_thing.global_position.distance_squared_to(pos):
			closest_thing = thing
	return closest_thing

func dir(direction):
	if direction is int or direction is float:
		return Vector2.from_angle(direction)
	else:
		return direction.normalized()
