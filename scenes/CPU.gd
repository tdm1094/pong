extends StaticBody2D

var ball_position : Vector2
var distance : int
var move_by : int
var window_height : int
var paddle_height : int


# Called when the node enters the scene tree for the first time.
func _ready():
	window_height = get_viewport_rect().size.y
	paddle_height= $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Move paddle towards ball
	ball_position = $"../Ball".position
	distance = position.y - ball_position.y
	
	if abs(distance) > get_parent().PADDLE_SPEED * delta:
		move_by = get_parent().PADDLE_SPEED * delta * (distance / abs(distance))
	else:
		move_by = distance
	
	position.y -= move_by
	
	#Limit paddle movement to window
	position.y = clamp(position.y, paddle_height / 2, window_height - paddle_height / 2)
