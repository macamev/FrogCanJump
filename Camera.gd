extends Camera2D

export (NodePath) var player_path
var player
var score = 0
var highscore = 0

var SAVE_FILE_PATH = 'user://save.save'


# Called when the node enters the scene tree for the first time.
func _ready():
	load_high()
	player = get_node(player_path)
	$Score/Score.text = 'Score: 0'
	$Score/Best.text = 'Best: ' + str(highscore / 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	moveCamera()
	updateScore()
	
func moveCamera():
	var player_y = player.position.y
	if player_y < position.y:
		position = (Vector2(0, player_y))
		score += 1
		if score > highscore:
			highscore = score
			save_high()

func updateScore():
	$Score/Score.text = 'Score: ' + str(score / 10)

func save_high():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_high():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var(highscore)
		save_data.close()




