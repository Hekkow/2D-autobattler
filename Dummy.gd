extends Enemy

func _init():
	health = 100
	original_color = Color.BLACK
	GameData.active_enemies.append(self)


func _physics_process(_delta):
	pass

