extends Fish

var move_right
var max_scale = 3.0

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	rng.randomize()
	move_right = rng.randi_range(0, 1)

	# set size
	_scale = rng.randf_range(0.05, max_scale)
	var hitbox = $CollisionShape2D
	pixels_wide = hitbox.shape.extents.x * _scale

	# set side of screen based on movement direction
	if move_right:
		position.x = -pixels_wide/2
	else:
		position.x = v_size.x+pixels_wide/2
	position.y = rng.randf_range(0, v_size.y) 	# set height too

	# set speed
	move_speed = 60 * rng.randi_range(1, 4)
	$AnimatedSprite.flip_h = move_right
	scale = _scale * Vector2(1, 1)
	$AnimatedSprite.set_modulate(Color.from_hsv(_scale / max_scale, .6, 1.0))


func _physics_process(_delta):
	# move the direction you're facing, Fish
	if move_right:
		position.x += move_speed * _delta
	else:
		position.x -= move_speed * _delta
	
	#$AnimatedSprite.set_modulate(Color.from_hsv(position.x / max_scale, .6, 1.0))
	
	# despawn when off screen
	if (move_right and position.x > v_size.x + pixels_wide) \
	or (!move_right and position.x < -pixels_wide):
		queue_free()
