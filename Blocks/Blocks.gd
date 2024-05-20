extends Node

var blocks := []
func _ready():
	var folder_path = "res://Blocks/IndividualBlocks"
	var paths = Helper.get_file_names(folder_path)
	for path in paths:
		blocks.append(load(folder_path + "/" + path))
