extends KinematicBody2D

var velocity = Vector2.ZERO

export var rotation_speed = PI

var arrowPos
var rotate = true
var arrowMax = 90
var arrowMin = -90
var getArrow
var collision



# Called when the node enters the scene tree for the first time.
func _ready():
	arrowPos = $AnimatedSprite/Position2D
	pass # Replace with function body.
	

func _physics_process(_delta):
	jump()
	arrow()
	teleport()
	

#func _process(delta):
#	pass


func arrow():
	if rotate == true:
		arrowPos.rotation_degrees += rotation_speed
	if rotate == false:
		arrowPos.rotation_degrees -= rotation_speed
		
	if rotate == true && arrowPos.rotation_degrees > 90:
		arrowPos.rotation_degrees -= rotation_speed
		rotate = false
		
	if rotate == false && arrowPos.rotation_degrees <= -90:
		rotate = true

func jump():
	
	velocity.y += 6
	velocity = move_and_slide(velocity, Vector2.UP, true)
	
	for i in get_slide_count():
		collision = get_slide_collision(i)
		if collision.collider.is_in_group("platform"):
			velocity.x = 0
		if Input.is_action_just_pressed("ui_up") and collision.collider.is_in_group("platform"):
			velocity.y -= 95
			velocity += Vector2(1,0) + ($AnimatedSprite/Position2D/Sprite.global_position - global_position).normalized() * 200

func teleport():
	if position.x < -10.0:
		position.x = 190
	elif position.x > 190:
		position.x = -10

