extends Node2D

var platform = preload('res://Platform.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	startSpawnPlatforms()


func _process(_delta):
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group('platform'):
		#look in to deferred function
		var new_platform = platform.instance()
		call_deferred("add_child", new_platform)
		new_platform.position = Vector2(rand_range(10, 160), $Player.position.y - 150)
		body.queue_free()
	if body.is_in_group('player'):
		get_tree().reload_current_scene()

func startSpawnPlatforms():
	var increment = 0;
	for n in 11:
		increment += 40
		var new_platform = platform.instance()
		call_deferred("add_child", new_platform)
		new_platform.position = Vector2(rand_range(10, 160), $Player.position.y - increment)
