extends Fish

var move_right

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	move_right = true
	$AnimatedSprite.flip_h = move_right
	scale = Vector2(1.2, 1.2)

func _physics_process(_delta):
	# move the direction you're facing, Fish
	if move_right:
		position.x += speed * _delta
	else:
		position.x -= speed * _delta
	
	# despawn when off screen
	if (move_right and position.x > v_size.x + pixels_wide) \
	or (!move_right and position.x < -pixels_wide):
		queue_free()
