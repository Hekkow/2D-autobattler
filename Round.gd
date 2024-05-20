extends Node
class_name Round
var enemies = []
var waves = []
func _init(_waves, number_of_waves=1, minimum_per_wave=1):
	for i in _waves:
		for amount in i.amount:
			enemies.append(i.enemy)
	enemies.shuffle()
	for i in number_of_waves:
		waves.append([])
		for x in minimum_per_wave:
			waves[i].append(enemies.pop_front())
	for i in len(enemies):
		waves.pick_random().append(enemies.pop_front())
func _to_string():
	var string = ""
	for i in len(waves):
		string += "\nWave " + str(i) + "\n"
		for x in waves[i]:
			string += str(waves[i][x]) + ", "
	return string
