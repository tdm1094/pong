extends CharacterBody2D

var window_size : Vector2
const START_SPEED : int = 500
const ACCELERATION : int = 50
var speed : int
var direction : Vector2
const MAX_Y_VECTOR : float = 0.6

func _ready():
	window_size = get_viewport_rect().size
	
func new_ball():
	#Randomize start position and direction
	position.x = window_size.x / 2
	position.y = randi_range(200, window_size.y - 200)
	speed = START_SPEED
	direction = random_direction()
	
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#If ball hits paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCELERATION
			direction = new_direction(collider)
		else:
			direction = direction.bounce(collision.get_normal())
	
func random_direction():
	var new_direction := Vector2()
	new_direction.x = [1, -1].pick_random()
	new_direction.y = randf_range(-1, 1)
	return new_direction.normalized()

func new_direction(collider):
	var ball_y = position.y
	var paddle_y = collider.position.y
	var distance = ball_y - paddle_y
	var new_direction := Vector2()
	
	#Flip the horizontal direction
	if direction.x > 0:
		new_direction.x = -1
	else:
		new_direction.x = 1
	new_direction.y = (distance / (collider.paddle_height / 2)) * MAX_Y_VECTOR
	return new_direction.normalized()
