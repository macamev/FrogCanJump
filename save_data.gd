extends Node


# Declare member variables here. Examples:

var savePath = 'user://save.save'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_game(bestScore):
	var data = {
		"bestScore" : bestScore
	}
	var file = File.new()
	var error = file.open(savePath, File.WRITE)
	if error == OK:
		file.store_line(to_json(data))
		file.close()

func load_game(bestScore):
	var file = File.new()
	if file.file_exists(savePath):
		var error = file.open(savePath, File.READ)
		if error == OK:
			bestScore = file.get_var()
			file.close() 
